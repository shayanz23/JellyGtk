using Jellyplayer.Api.Models;

namespace Jellyplayer {

    [GtkTemplate (ui = "/com/shayanz23/JellyGtk/gtk/signInWindow.ui")]

    public class SignInWindow : Adw.Window {

        private new Jellyplayer.Application application;

        [GtkChild]
        private unowned Adw.EntryRow url_entry;

        [GtkChild]
        private unowned Adw.EntryRow username_entry;

        [GtkChild]
        private unowned Adw.EntryRow password_entry;

        public SignInWindow (Jellyplayer.Application app) {
            application = app;
        }

        [GtkCallback]
        private bool on_close_request () {
            application.quit ();
            return false;
        }


        [GtkCallback]
        private void on_sign_in_button_clicked() {
            LoginData login_data;

            if (username_entry.text.length != 0 && password_entry.text.length != 0 ) {
                login_data = new LoginData(username_entry.text, password_entry.text);
                message (login_data.Username);
                message (login_data.Password);
            } else {
                message("either username or password is empty.");
                return;
            }

            message (Jellyfin.Api.Authentication.login(login_data, url_entry.get_text()));

            application.signedIn = true;

            this.destroy();
        }
    }
}

