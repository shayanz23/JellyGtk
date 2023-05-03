
namespace Jellyplayer {
    [GtkTemplate (ui = "/com/shayanz23/JellyPlayer/signInWindow.ui")]
    public class SignInWindow : Adw.Window {
        private Jellyplayer.Application application;

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
            application.signedIn = true;
            this.destroy();
        }
    }
}

