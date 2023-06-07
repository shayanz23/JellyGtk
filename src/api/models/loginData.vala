namespace Jellyplayer.Api.Models {

    public class LoginData {

        public string Username {get; set; }

        public string Password {get; set; }

        public LoginData(string username, string password) {
            Username = username;
            Password = password;
        }

        public Json.Node to_json() {

            var obj = new Json.Object();

            obj.set_string_member("Username", Username);
            obj.set_string_member("Pw", Password);

            var node = new Json.Node(Json.NodeType.OBJECT);
            node.init_object(obj);

            return node;

        }

    }

}
