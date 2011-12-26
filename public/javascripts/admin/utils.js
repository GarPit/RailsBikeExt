var ru2en = { 
  ru_str : "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя", 
  en_str : ['A','B','V','G','D','E','JO','ZH','Z','I','J','K','L','M','N','O','P','R','S','T',
    'U','F','H','C','CH','SH','SHH',String.fromCharCode(35),'I',String.fromCharCode(39),'JE','JU',
    'JA','a','b','v','g','d','e','jo','zh','z','i','j','k','l','m','n','o','p','r','s','t','u','f',
    'h','c','ch','sh','shh',String.fromCharCode(35),'i',String.fromCharCode(39),'je','ju','ja'], 
  translit : function(org_str) { 
    var tmp_str = ""; 
    for(var i = 0, l = org_str.length; i < l; i++) { 
      var s = org_str.charAt(i), n = this.ru_str.indexOf(s); 
      if(n >= 0) { tmp_str += this.en_str[n]; } 
      else { tmp_str += s; } 
    } 
    return tmp_str; 
  } 
}


function makeSlug(val, sep) { // code largely inspired by http://www.thewebsitetailor.com/jquery-slug-plugin/
  if (typeof val == 'undefined') return('');
  val = ru2en.translit(val);
  if (typeof sep == 'undefined') sep = '_';
  var alphaNumRegexp = new RegExp('[^a-zA-Z0-9\\' + sep + ']', 'g');
  var avoidDuplicateRegexp = new RegExp('[\\' + sep + ']{2,}', 'g');
  val = val.replace(/\s/g, sep);
  val = val.replace(alphaNumRegexp, '');
  val = val.replace(avoidDuplicateRegexp, sep);
  return val.toLowerCase();
}

(function() {
  String.prototype.trim = function() {
    return this.replace(/^\s+/g, '').replace(/\s+$/g, '');
  }
})();

Object.size = function(obj) {
  var size = 0, key;
  for (key in obj) {
    if (obj.hasOwnProperty(key)) size++;
  }
  return size;
};

// Make a DOM option for a select box. This code works around a bug in IE
function makeOption(text, value, defaultSelected, selected) {
  var option = new Option('', value, defaultSelected, selected);
  $(option).text(text);
  return option;
}