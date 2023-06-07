namespace Jellyfin.Api.Models {

    public class SessionInfo
    {
        public PlayState PlayState { get; set; }
        public unowned List<Object> AdditionalUsers { get; set; }
        public Capabilities Capabilities { get; set; }
        public string RemoteEndPoint { get; set; }
        public unowned List<string> PlayableMediaTypes { get; set; }
        public string Id { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string Client { get; set; }
        public DateTime LastActivityDate { get; set; }
        public DateTime LastPlaybackCheckIn { get; set; }
        public string DeviceName { get; set; }
        public string DeviceId { get; set; }
        public string ApplicationVersion { get; set; }
        public bool IsActive { get; set; }
        public bool SupportsMediaControl { get; set; }
        public bool SupportsRemoteControl { get; set; }
        public unowned List<Object> NowPlayingQueue { get; set; }
        public unowned List<Object> NowPlayingQueueFullItems { get; set; }
        public bool HasCustomDeviceName { get; set; }
        public string ServerId { get; set; }
        public unowned List<Object> SupportedCommands { get; set; }
    }

    public class Capabilities
    {
        public unowned List<Object> PlayableMediaTypes { get; set; }
        public unowned List<Object> SupportedCommands { get; set; }
        public bool SupportsMediaControl { get; set; }
        public bool SupportsContentUploading { get; set; }
        public bool SupportsPersistentIdentifier { get; set; }
        public bool SupportsSync { get; set; }
    }

    public class PlayState
    {
        public bool CanSeek { get; set; }
        public bool IsPaused { get; set; }
        public bool IsMuted { get; set; }
        public string RepeatMode { get; set; }
    }

}
