using Jellyplayer.Api.Models;

namespace Jellyfin.Api {

    public class Authentication {

        public static string token;
        public static string authorization;
        public static string authorization_with_token;
        public static new Jellyplayer.Application Application {get; set;}


        public static string login(LoginData login_data, string url) {
            authorization = "MediaBrowser Client=\"other\", Device=\"my-script\", DeviceId=\"some-unique-id\", Version=\"0.0.0\"";
            var session = new Soup.Session ();
            var soup_msg = new Soup.Message ("POST", url + "/Users/AuthenticateByName");
            soup_msg.request_headers.append("Authorization", authorization);
            message ("header: " + soup_msg.request_headers.get_one("Authorization"));
            if (soup_msg == null) {
                return "invalid url";
            }

            var gen = new Json.Generator();

            Json.Node json_node = login_data.to_json();

            gen.set_root(json_node);


            string response = get_login_response(session, soup_msg, gen);
            string access_token = set_token(response);


            return access_token;
        }


        public static string get_login_response(Soup.Session session, Soup.Message msg, Json.Generator gen) {

            size_t json_length;

            string json_string = gen.to_data(out json_length);
            if (json_length == 0) {
                return "broken request json.";
            }
            message(json_string);

            msg.set_request_body("application/json", new GLib.MemoryInputStream.from_data (json_string.data, GLib.g_free), (ssize_t)json_length);

            try {
                Bytes bytes = session.send_and_read(msg, null);
                string res_str = (string)bytes.get_data();
                return res_str;
            } catch (Error e) {
                return e.message;
            }
        }

        public static string set_token(string response) {

            Json.Parser parser = new Json.Parser ();

            try {
		        parser.load_from_data (response);

		        // Get the root node:
		        Json.Node root_node = parser.get_root();
;
		        Json.Object root_obj = root_node.get_object();

		        string access_token = root_obj.get_string_member("AccessToken");

		        authorization_with_token = authorization + @", Token=\"$access_token\"";
		        token = access_token;
		        message("authorization with token: " + authorization_with_token);

                return access_token;
	        } catch (Error e) {
		        message ("Unable to parse the string: %s\n", e.message);
	        }
            return "Unable to load json";
        }
    }

}
