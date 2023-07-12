/* application.vala
 *
 * Copyright 2023 Shayan Zahedanaraki
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Jellygtk {
    public class Application : Adw.Application {
        public bool signedIn { get; set; }
        public Application () {
            Object (application_id: "com.shayanz23.JellyGtk", flags: ApplicationFlags.DEFAULT_FLAGS);
        }

        construct {
            ActionEntry[] action_entries = {
                { "about", this.on_about_action },
                { "preferences", this.on_preferences_action },
                { "sign-out", this.on_sign_out },
                { "quit", this.quit }
            };
            this.add_action_entries (action_entries, this);
            this.set_accels_for_action ("app.quit", {"<primary>q"});
        }

        public override void activate () {
            base.activate ();
            var win = this.active_window;
            if (win == null) {
                win = new Jellygtk.Window (this);
            }
            win.present ();
            signedIn = Jellyfin.Api.Authentication.authenticate_using_token ();
            show_login_window();
        }

        private void on_about_action () {
            string[] developers = { "Shayan" };
            var about = new Adw.AboutWindow () {
                transient_for = this.active_window,
                application_name = "jellygtk",
                application_icon = "com.shayanz23.JellyGtk",
                developer_name = "Shayan Zahedanaraki",
                version = "0.1.0",
                developers = developers,
                copyright = "© 2023 Shayan Zahedanaraki",
            };

            about.present ();
        }

        private void show_login_window() {
            if (signedIn == false) {
                Jellyfin.Api.Authentication.delete_auth_files ();
                var signIn = new Jellygtk.SignInWindow (this) {
                    transient_for = this.active_window,
                    modal = true,
                };
                signIn.present ();
            }
        }

        private void on_preferences_action () {
            message ("app.preferences action activated");
        }

        private void on_sign_out () {
            message ("app sign out activated");
            signedIn = false;
            show_login_window();
        }


    }
}

