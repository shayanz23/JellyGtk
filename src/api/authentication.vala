using Jellyplayer.Api.Models;

namespace Jellyfin.Api {

    public class Authentication {

        public static string token;
        public static string authorization_with_token;


        public static string login(LoginData login_data, string url) {
            string authorization = "MediaBrowser Client=\"other\", Device=\"my-script\", DeviceId=\"some-unique-id\", Version=\"0.0.0\"";
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

            return response;
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

    }

}
