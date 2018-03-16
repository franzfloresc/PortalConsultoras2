using System.Collections.Generic;

namespace Portal.Consultoras.Common
{
    public class MandrillMail
    {
        public string key { get; set; }
        public Message message { get; set; }
    }

    public class Message
    {
        public string html { get; set; }
        public string text { get; set; }
        public string subject { get; set; }
        public string from_email { get; set; }
        public string from_name { get; set; }
        public List<To> to { get; set; }
        public Headers headers { get; set; }
        public bool important { get; set; }
        public bool? track_opens { get; set; }
        public bool? track_clicks { get; set; }
        public bool? auto_text { get; set; }
        public bool? auto_html { get; set; }
        public bool? inline_css { get; set; }
        public bool? url_strip_qs { get; set; }
        public bool? preserve_recipients { get; set; }
        public string bcc_address { get; set; }
        public string tracking_domain { get; set; }
        public string signing_domain { get; set; }
        public bool merge { get; set; }
        public List<GlobalMergeVars> global_merge_vars { get; set; }
        public List<MergeVars> merge_vars { get; set; }
        public string[] tags { get; set; }
        public string[] google_analytics_domains { get; set; }
        public string google_analytics_campaign { get; set; }
        public Metadata metadata { get; set; }
        public List<RecipientMetadata> recipient_metadata { get; set; }
        public List<Attachments> attachments { get; set; }
        public List<Images> images { get; set; }
        public bool async { get; set; }
    }

    public class To
    {
        public string email { get; set; }
        public string name { get; set; }
    }
    public class Headers
    {
        public string Reply_To { get; set; }
    }
    public class GlobalMergeVars
    {
        public string name { get; set; }
        public string content { get; set; }
    }
    public class MergeVars
    {
        public string rcpt { get; set; }
        public Vars[] vars { get; set; }
    }
    public class Metadata
    {
        public string website { get; set; }
    }
    public class Values
    {
        public string user_id { get; set; }
    }
    public class Vars
    {
        public string name { get; set; }
        public string content { get; set; }
    }
    public class RecipientMetadata
    {
        public string rcpt { get; set; }
        public Values values { get; set; }
    }
    public class Attachments
    {
        public string type { get; set; }
        public string name { get; set; }
        public string content { get; set; }
    }
    public class Images
    {
        public string type { get; set; }
        public string name { get; set; }
        public string content { get; set; }
    }
}