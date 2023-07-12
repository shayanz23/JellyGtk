using Gee;

namespace Jellygtk.Api.Models {

    public class User {
        public string name { get; set; }
        public string server_id { get; set; }
        public string id { get; set; }
        public bool has_password { get; set; }
        public bool has_configured_password{ get; set; }
        public bool has_configured_easy_password { get; set; }
        public bool enable_auto_login { get; set; }
        public DateTime last_login_date { get; set; }
        public DateTime last_activity_date { get; set; }
        public UserConfiguration configuration { get; set; }
        public UserPolicy policy { get; set; }
    }

    public class UserConfiguration {
        public bool play_default_audio_track { get; set; }
        public string subtitle_language_preference { get; set; }
        public bool display_missing_episodes { get; set; }
        public ArrayList<string> grouped_folders { get; set; }
        public string subtitle_mode { get; set; }
        public bool display_collections_view { get; set; }
        public bool enable_local_password { get; set; }
        public ArrayList<string> ordered_views { get; set; }
        public ArrayList<string> latest_items_excludes { get; set; }
        public ArrayList<string> my_media_excludes { get; set; }
        public bool hide_played_in_latest { get; set; }
        public bool remember_audio_selections { get; set; }
        public bool remember_subtitle_selections { get; set; }
        public bool enable_next_episode_auto_play { get; set; }
    }

    public class UserPolicy {
        public bool is_administrator { get; set; }
        public bool is_hidden { get; set; }
        public bool is_disabled { get; set; }
        public ArrayList<string> blocked_tags { get; set; }
        public bool enable_user_preference_access { get; set; }
        public ArrayList<string> access_schedules { get; set; }
        public ArrayList<string> block_unrated_items { get; set; }
        public bool enable_remote_control_of_other_users { get; set; }
        public bool enable_shared_device_control { get; set; }
        public bool enable_remote_access { get; set; }
        public bool enable_live_tv_management { get; set; }
        public bool enable_live_tv_access { get; set; }
        public bool enable_media_playback { get; set; }
        public bool enable_audio_playback_transcoding { get; set; }
        public bool enable_video_playback_transcoding { get; set; }
        public bool enable_playback_remuxing { get; set; }
        public bool force_remote_source_transcoding { get; set; }
        public bool enable_content_deletion { get; set; }
        public ArrayList<string> enable_content_deletion_from_folders { get; set; }
        public bool enable_content_downloading { get; set; }
        public bool enable_sync_transcoding { get; set; }
        public bool enable_media_conversion { get; set; }
        public ArrayList<string> enabled_devices { get; set; }
        public bool enable_all_devices { get; set; }
        public ArrayList<string> enabled_channels { get; set; }
        public bool enable_all_channels { get; set; }
        public ArrayList<string> enabled_folders { get; set; }
        public bool enable_all_folders { get; set; }
        public int invalid_login_attempt_count { get; set; }
        public int login_attempts_before_lockout { get; set; }
        public int max_active_sessions { get; set; }
        public bool enable_public_sharing { get; set; }
        public ArrayList<string> blocked_media_folders { get; set; }
        public ArrayList<string> blocked_channels { get; set; }
        public int remote_client_bitrate_limit { get; set; }
        public string authentication_provider_id { get; set; }
        public string password_reset_provider_id { get; set; }
        public string sync_play_access { get; set; }
    }

}
