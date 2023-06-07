
namespace Jellyfin.Api.Models {

    public class User
    {
        public string Name { get; set; }
        public string ServerId { get; set; }
        public string Id { get; set; }
        public bool HasPassword { get; set; }
        public bool HasConfiguredPassword { get; set; }
        public bool HasConfiguredEasyPassword { get; set; }
        public bool EnableAutoLogin { get; set; }
        public DateTime LastLoginDate { get; set; }
        public DateTime LastActivityDate { get; set; }
        public Configuration Configuration { get; set; }
    }


    public class Configuration
    {
        public bool PlayDefaultAudioTrack { get; set; }
        public string SubtitleLanguagePreference { get; set; }
        public bool DisplayMissingEpisodes { get; set; }
        public List<Object> GroupedFolders { get; set; }
        public string SubtitleMode { get; set; }
        public bool DisplayCollectionsView { get; set; }
        public bool EnableLocalPassword { get; set; }
        public List<Object> OrderedViews { get; set; }
        public List<Object> LatestItemsExcludes { get; set; }
        public List<Object> MyMediaExcludes { get; set; }
        public bool HidePlayedInLatest { get; set; }
        public bool RememberAudioSelections { get; set; }
        public bool RememberSubtitleSelections { get; set; }
        public bool EnableNextEpisodeAutoPlay { get; set; }
    }

}
