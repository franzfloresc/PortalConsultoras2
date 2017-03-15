﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Portal.Consultoras.Common
{
    public static class ExtensionMethods
    {
        public static int ToInt(this object obj)
        {
            return Convert.ToInt32(obj);
        }

        public static int ToIntDefault(this int? obj)
        {
            return obj.HasValue ? obj.Value : 0;
        }

        public static int ToIntDefault(this int? obj, int defaultValue)
        {
            return obj.HasValue ? obj.Value : defaultValue;
        }

        public static bool TryParse(this string obj)
        {
            int temp;
            return int.TryParse(obj, out temp);
        }

        public static bool ToBool(this object obj)
        {
            return Convert.ToBoolean(obj);
        }

        public static char ToChar(this object obj)
        {
            return Convert.ToChar(obj);
        }

        public static decimal ToDecimal(this object obj)
        {
            var ui = new CultureInfo("es-PE");
            ui.NumberFormat = new NumberFormatInfo() { NumberDecimalSeparator = "." };
            return Convert.ToDecimal(obj, ui);
        }

        public static decimal ToDecimal(this decimal? obj)
        {
            return obj.HasValue ? obj.Value : 0;
        }

        public static decimal? ToNullableDecimal(this decimal obj)
        {
            return obj != 0 ? (decimal?)obj : default(decimal?);
        }

        public static decimal ToDecimalZeros(this decimal obj, int numberOfDecimals)
        {
            return Math.Round(obj, numberOfDecimals);
        }

        public static double ToDouble(this object obj)
        {
            return Convert.ToDouble(obj);
        }

        public static string ToDecimalPointFormat(this decimal obj)
        {
            return obj.ToString("0.00", new NumberFormatInfo() { NumberDecimalSeparator = "." });
        }

        public static string ToDecimalPointFormat(this decimal obj, string format)
        {
            return obj.ToString(format, new NumberFormatInfo() { NumberDecimalSeparator = "." });
        }

        public static DateTime ToDatetime(this string obj)
        {
            return DateTime.Parse(obj);
        }

        public static DateTime ToDatetime(this string obj, string format)
        {
            return DateTime.ParseExact(obj, format, null);
        }

        public static DateTime ToDatetimeCulture(this string obj, string culture)
        {
            var ui = new CultureInfo(culture);
            ui.NumberFormat = new NumberFormatInfo() { NumberDecimalSeparator = "." };
            return DateTime.Parse(obj);
        }

        public static Nullable<int> ToNullableInt(this object obj)
        {
            return (int?)obj;
        }

        public static Nullable<DateTime> ToNullableDatetime(this DateTime date)
        {
            return (DateTime?)date;
        }

        public static string ToFormattedStringDate(this DateTime obj)
        {
            return obj.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
        }

        public static string ToFullFormattedStringDate(this DateTime obj)
        {
            return obj.ToString("dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);
        }

        public static string ToFormattedDate(this DateTime obj)
        {
            return obj.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
        }

        public static string ToFormattedDate(this DateTime obj, string format)
        {
            return obj.ToString(format, CultureInfo.InvariantCulture);
        }

        public static string ToFormattedTime12Hours(this DateTime obj)
        {
            return obj.ToString("hh:mm tt", CultureInfo.InvariantCulture);
        }

        public static string ToFormattedTime24Hours(this DateTime obj)
        {
            return obj.ToString("HH:mm", CultureInfo.InvariantCulture);
        }

        public static string ToFormattedTime(this DateTime obj, string format)
        {
            return obj.ToString(format, CultureInfo.InvariantCulture);
        }

        public static string ToTimeHourMinuteFormat(this TimeSpan obj)
        {
            return obj.ToString(@"hh\:mm");
        }

        public static string ToTimeHourMinuteFormat(this DateTime obj)
        {
            return obj.ToString(@"hh\:mm");
        }

        public static string ToTimeHourMinuteFormat(this TimeSpan? obj)
        {
            return obj.HasValue ? obj.Value.ToString(@"hh\:mm") : "00:00";
        }

        public static byte[] ToBytesFromBase64String(this string obj)
        {
            return Convert.FromBase64String(obj);
        }

        public static string ToFileFormattedStringDate(this DateTime obj)
        {
            return obj.ToString("yyyyMMdd", CultureInfo.InvariantCulture);
        }

        public static string ToFormattedMoneySolesString(this object obj)
        {
            return string.Format(CultureInfo.GetCultureInfo("es-PE"), "{0:C}", obj);
        }

        public static string ToFormattedMoneyDolarString(this object obj)
        {
            return string.Format(CultureInfo.GetCultureInfo("en-US"), "{0:C}", obj);
        }

        public static string ToFormattedPercentString(this object obj)
        {
            return string.Format(CultureInfo.GetCultureInfo("en-PE"), "{0:P}", obj.ToDecimal() / 100);
        }

        public static string ToStringWithSlash(this object obj)
        {
            return obj.ToString() + "/";
        }

        public static string ToMoneyFormat(this decimal obj)
        {
            return string.Format("S/. {0:0.00}", obj);
        }

        public static IEnumerable<string> SplitInParts(this string obj, int numberOfCharacters)
        {
            for (var i = 0; i < obj.Length; i += numberOfCharacters)
            {
                yield return obj.Substring(i, Math.Min(numberOfCharacters, obj.Length - i));
            }
        }

        public static string ToUpper(this string obj, int numberOfCharacters)
        {
            return obj.Substring(0, numberOfCharacters).ToUpper() + obj.Substring(numberOfCharacters);
        }

        public static string ToLower(this string obj, int numberOfCharacters)
        {
            return obj.Substring(0, numberOfCharacters).ToLower() + obj.Substring(numberOfCharacters);
        }
    }
}