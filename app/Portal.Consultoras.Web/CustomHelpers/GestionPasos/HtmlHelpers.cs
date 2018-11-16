using Portal.Consultoras.Web.Annotations;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text.RegularExpressions;
using System.Web.Mvc;
using System.Web.Mvc.Html;
using System.Xml;

namespace Portal.Consultoras.Web.GestionPasos
{
    public static class HtmlHelpers
    {
        public static MvcHtmlString TextBoxForExpressionRequiredIf<TModel, TValue>(this HtmlHelper<TModel> html,
           Expression<Func<TModel, TValue>> expression, object additionalViewData = null)
        {
            string mvcHtml = html.TextBoxFor(expression, additionalViewData).ToString();

            string element =
                html.ViewContext.ViewData.TemplateInfo.GetFullHtmlFieldName(
                    ExpressionHelper.GetExpressionText(expression));

            string key = html.ViewData.Model + "." + element;

            if (ExpressionRequiredIfAttribute.CountPerField != null)
            {
                ExpressionRequiredIfAttribute.CountPerField.Remove(key);

                if (ExpressionRequiredIfAttribute.CountPerField.Count == 0)
                    ExpressionRequiredIfAttribute.CountPerField = null;
            }

            string pattern = @"data\-val\-expressionrequiredif[a-z]+";

            return Regex.IsMatch(mvcHtml, pattern) ? MergeClientValidationRules(mvcHtml) : MvcHtmlString.Create(mvcHtml);
        }

        public static MvcHtmlString MergeClientValidationRules(string str)
        {
            const string searchStr = "data-val-expressionrequiredif";
            const string valListaValuesStr = "listvalues";
            const string valOtherPropertyStr = "otherproperty";
            const string valExpresionStr = "expresion";
            const string valRegexNotMatchStr = "regexnotmatch";

            var mainAttribs = new List<XmlAttribute>();
            var valListaValuesAttribs = new List<XmlAttribute>();
            var valOtherPropertyAttribs = new List<XmlAttribute>();
            var valExpresionAttribs = new List<XmlAttribute>();
            var valRegexNotMatchAttribs = new List<XmlAttribute>();

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(str);
            XmlNode node = doc.DocumentElement;

            foreach (XmlAttribute attrib in node.Attributes)
            {
                if (attrib.Name.StartsWith(searchStr))
                {
                    if (attrib.Name.EndsWith("-" + valListaValuesStr))
                        valListaValuesAttribs.Add(attrib);
                    else if (attrib.Name.EndsWith("-" + valOtherPropertyStr))
                        valOtherPropertyAttribs.Add(attrib);
                    else if (attrib.Name.EndsWith("-" + valExpresionStr))
                        valExpresionAttribs.Add(attrib);
                    else if (attrib.Name.EndsWith("-" + valRegexNotMatchStr))
                        valRegexNotMatchAttribs.Add(attrib);
                    else
                        mainAttribs.Add(attrib);
                }
            }
            var mainAttrib = doc.CreateAttribute(searchStr + "multiple");
            var valListaValuesAttrib = doc.CreateAttribute(searchStr + "multiple-" + valListaValuesStr);
            var valOtherPropertyAttrib = doc.CreateAttribute(searchStr + "multiple-" + valOtherPropertyStr);
            var valExpresionAttrib = doc.CreateAttribute(searchStr + "multiple-" + valExpresionStr);
            var valRegexNotMatchAttrib = doc.CreateAttribute(searchStr + "multiple-" + valRegexNotMatchStr);

            mainAttribs.ForEach(attrib =>
            {
                mainAttrib.Value += attrib.Value + "!";
                node.Attributes.Remove(attrib);
            });

            valListaValuesAttribs.ForEach(attrib =>
            {
                valListaValuesAttrib.Value += attrib.Value + "!";
                node.Attributes.Remove(attrib);
            });

            valOtherPropertyAttribs.ForEach(attrib =>
            {
                valOtherPropertyAttrib.Value += attrib.Value + "!";
                node.Attributes.Remove(attrib);
            });

            valExpresionAttribs.ForEach(attrib =>
            {
                valExpresionAttrib.Value += attrib.Value + "!";
                node.Attributes.Remove(attrib);
            });

            valRegexNotMatchAttribs.ForEach(attrib =>
            {
                valRegexNotMatchAttrib.Value += attrib.Value + "!";
                node.Attributes.Remove(attrib);
            });


            mainAttrib.Value = mainAttrib.Value.TrimEnd('!');
            valListaValuesAttrib.Value = valListaValuesAttrib.Value.TrimEnd('!');
            valOtherPropertyAttrib.Value = valOtherPropertyAttrib.Value.TrimEnd('!');
            valExpresionAttrib.Value = valExpresionAttrib.Value.TrimEnd('!');
            valRegexNotMatchAttrib.Value = valRegexNotMatchAttrib.Value.TrimEnd('!');

            node.Attributes.Append(mainAttrib);
            node.Attributes.Append(valListaValuesAttrib);
            node.Attributes.Append(valOtherPropertyAttrib);
            node.Attributes.Append(valExpresionAttrib);
            node.Attributes.Append(valRegexNotMatchAttrib);

            return MvcHtmlString.Create(node.OuterXml);
        }
    }
}