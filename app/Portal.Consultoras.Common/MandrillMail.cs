using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Portal.Consultoras.Common
{
    public class MandrillMail
    {
        public string key;
        public Message message;
    }

    public class Message
    {
        public string html;
        public string text;
        public string subject;
        public string from_email;
        public string from_name;
        public List<To> to;
        public Headers headers;
        public bool important;
        public bool? track_opens;
        public bool? track_clicks;
        public bool? auto_text;
        public bool? auto_html;
        public bool? inline_css;
        public bool? url_strip_qs;
        public bool? preserve_recipients;
        public string bcc_address;
        public string tracking_domain;
        public string signing_domain;
        public bool merge;
        public List<GlobalMergeVars> global_merge_vars;
        public List<MergeVars> merge_vars;
        public string[] tags;
        public string[] google_analytics_domains;
        public string google_analytics_campaign;
        public Metadata metadata;
        public List<RecipientMetadata> recipient_metadata;
        public List<Attachments> attachments;
        public List<Images> images;
        public bool async;
    }

    public class To
    {
        public string email;
        public string name;
    }
    public class Headers
    {
        public string Reply_To;
    }
    public class GlobalMergeVars
    {
        public string name;
        public string content;
    }
    public class MergeVars
    {
        public string rcpt;
        public Vars[] vars;
    }
    public class Metadata
    {
        public string website;
    }
    public class Values
    {
        public string user_id;
    }
    public class Vars
    {
        public string name;
        public string content;
    }
    public class RecipientMetadata
    {
        public string rcpt;
        public Values values; 
    }
    public class Attachments
    {
        public string type;
        public string name;
        public string content;
    }
    public class Images
    {
        public string type;
        public string name;
        public string content;
    }
}
