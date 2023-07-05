using Jellyplayer.Api.Models;

namespace Jellyfin.Api {

    public class Authentication {

        public static string auth_token;
        public static string authorization;
        public static string authorization_with_token;
        public static new Jellyplayer.Application Application {get; set;}


        public static int login (LoginData login_data, string url) {
            authorization = "MediaBrowser Client=\"other\", Device=\"my-script\", DeviceId=\"some-unique-id\", Version=\"0.0.0\"";
            var session = new Soup.Session ();
            var soup_msg = new Soup.Message ("POST", url + "/Users/AuthenticateByName");
            string json_response;
            soup_msg.request_headers.append ("Authorization", authorization);
            message ("header: " + soup_msg.request_headers.get_one ("Authorization"));
            if (soup_msg == null) {
                message ("invalid url");
                return -1;
            }

            var gen = new Json.Generator ();

            Json.Node json_node = login_data.to_json ();

            gen.set_root(json_node);


            int response = get_login_response (out json_response ,session, soup_msg, gen);

            if (response != 0) {
                return -1;
            }

            string access_token = set_token (json_response);
            string store_token_result = store_token (access_token);
            string store_url_result = store_url (url);

            if (store_token_result != "success") {
                message ("Failure:" + store_token_result);
                return -1;
            }

            if (store_url_result != "success") {
                message ("Failure:" + store_url_result);
                return -1;
            }

            message (store_token_result);
            message (store_url_result);
            message (access_token);

            return 0;
        }


        public static int get_login_response(out string json_response, Soup.Session session, Soup.Message msg, Json.Generator gen) {

            size_t json_length;

            string json_string = gen.to_data (out json_length);
            if (json_length == 0) {
                return -1;
            }
            message (json_string);

            msg.set_request_body ("application/json", new GLib.MemoryInputStream.from_data
                (json_string.data, GLib.g_free), (ssize_t)json_length);

            try {
                Bytes bytes = session.send_and_read(msg, null);
                if (msg.status_code != 200) {
                    message ("Json response code: " + msg.status_code.to_string ());
                    return -1;
                }
                json_response = (string)bytes.get_data();
                return 0;
            } catch (Error e) {
                message (e.message);
                return -1;
            }
        }

        public static string set_token (string response) {

            Json.Parser parser = new Json.Parser ();

            try {
		        parser.load_from_data (response);

		        // Get the root node:
		        Json.Node root_node = parser.get_root();

		        Json.Object root_obj = root_node.get_object();

		        string access_token = root_obj.get_string_member("AccessToken");

		        authorization_with_token = authorization + @", Token=\"$access_token\"";
		        auth_token = access_token;
		        message("authorization with token: " + authorization_with_token);

                return access_token;
	        } catch (Error e) {
		      message (response);
	        }
            return "Unable to load json";
        }

        public static string store_token (string input_token) {
        string data_path = Environment.get_user_data_dir ();
        string token_file_path = data_path + "/token.txt";

        File token_file = File.new_for_path(token_file_path);

        if (token_file.query_exists()) {

            try {
                token_file.delete();
            } catch (Error e) {
                return "unable delete existing token file ERROR: \n" + e.message;
            }
        }

        var dos = new DataOutputStream (token_file.create(FileCreateFlags.REPLACE_DESTINATION));

        try {
            dos.put_string(input_token);
        } catch (Error e) {
            return "unable put data in token file ERROR: \n" + e.message;
        }

        try {
            dos.close();
        } catch (Error e) {
            return "unable to close the file ERROR: \n" + e.message;
        }


        return "success";
    }

    public static string store_url (string url) {
        string data_path = Environment.get_user_data_dir ();
        string url_file_path = data_path + "/url.txt";

        File url_file = File.new_for_path(url_file_path);

        if (url_file.query_exists()) {

            try {
                url_file.delete();
            } catch (Error e) {
                return "unable delete existing token file ERROR: \n" + e.message;
            }
        }

        var dos = new DataOutputStream (url_file.create(FileCreateFlags.REPLACE_DESTINATION));

        try {
            dos.put_string(url);
        } catch (Error e) {
            return "unable put data in token file ERROR: \n" + e.message;
        }

        try {
            dos.close();
        } catch (Error e) {
            return "unable to close the file ERROR: \n" + e.message;
        }


        return "success";
    }

    public static bool check_token () {

        string access_token;
        string url;
        string json_res;
        int read_token_response = read_token (out access_token);
        int read_url_response = read_url (out url);

        if (read_token_response == -1 || read_url_response == -1) {
            return false;
        }

        if (get_user_response(url, access_token, out json_res) == -1) {
            return false;
        }

        message (json_res);

        return true;
    }

    public static int read_token (out string access_token) {
        string data_path = Environment.get_user_data_dir ();
        string token_file_path = data_path + "/token.txt";

        File token_file = File.new_for_path(token_file_path);

        if (!token_file.query_exists()) {
            return -1;
        }

        try {
            var dis = new DataInputStream(token_file.read ());
            access_token = dis.read_line (null);
        } catch (Error e) {

            return -1;
        }

        return 0;
    }


        public static int read_url (out string url) {
        string data_path = Environment.get_user_data_dir ();
        string token_file_path = data_path + "/url.txt";

        File token_file = File.new_for_path(token_file_path);

        if (!token_file.query_exists()) {
            return -1;
        }

        try {
            var dis = new DataInputStream(token_file.read ());
            url = dis.read_line (null);
        } catch (Error e) {

            return -1;
        }

        return 0;
    }

    public static int get_user_response (string url, string access_token, out string json_res) {
        string test_auth_access_token = @"MediaBrowser Client=\"other\", Device=\"my-script\", DeviceId=\"some-unique-id\", Version=\"0.0.0\", Token=\"$access_token\"";

        var session = new Soup.Session ();
        var soup_msg = new Soup.Message ("GET", url + "/Users/Me");
        soup_msg.request_headers.append ("Authorization", test_auth_access_token);
        message ("header: " + soup_msg.request_headers.get_one ("Authorization"));
        if (soup_msg == null) {
            return -1;
        }

        try {
            Bytes bytes = session.send_and_read(soup_msg, null);
            if (soup_msg.status_code != 200) {
                return -1;
            }
            message(soup_msg.status_code.to_string ());
            json_res = (string)bytes.get_data();
            return 0;
        } catch (Error e) {
            message (e.message);
            return -1;
        }
    }

    public static int delete_auth_files () {
        string data_path = Environment.get_user_data_dir ();
        string url_file_path = data_path + "/url.txt";
        string token_file_path = data_path + "/token.txt";

        File url_file = File.new_for_path(url_file_path);
        File token_file = File.new_for_path(token_file_path);

        if (url_file.query_exists()) {

            try {
                url_file.delete();
                token_file.delete();
            } catch (Error e) {
                return -1;
            }
        }

        return 0;
    }

    }

}

