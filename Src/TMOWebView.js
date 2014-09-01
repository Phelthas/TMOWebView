//JSON

JSON = {
    useHasOwn: ({}.hasOwnProperty ? true: false),
    pad: function(n) {
        return n < 10 ? "0" + n: n;
    },
    m: {
        "\b": '\\b',
        "\t": '\\t',
        "\n": '\\n',
        "\f": '\\f',
        "\r": '\\r',
        '"': '\\"',
        "\\": '\\\\'
    },
    encodeString: function(s) {
        if (/["\\\x00-\x1f]/.test(s)) {
            return '"' + s.replace(/([\x00-\x1f\\"])/g,
            function(a, b) {
                var c = JSON.m[b];
                if (c) {
                    return c;
                }
                c = b.charCodeAt();
                return "\\u00" + Math.floor(c / 16).toString(16) + (c % 16).toString(16);
            }) + '"';
        }
        return '"' + s + '"';
    },
    encodeArray: function(o) {
        var a = ["["],b, i, l = o.length,v;
        for (i = 0; i < l; i += 1) {
            v = o[i];
            switch (typeof v) {
            case "undefined":
            case "function":
            case "unknown":
                break;
            default:
                if (b) {
                    a.push(',');
                }
                a.push(v === null ? "null": this.encode(v));
                b = true;
            }
        }
        a.push("]");
        return a.join("");
    },
    encodeDate: function(o) {
        return '"' + o.getFullYear() + "-" + pad(o.getMonth() + 1) + "-" + pad(o.getDate()) + "T" + pad(o.getHours()) + ":" + pad(o.getMinutes()) + ":" + pad(o.getSeconds()) + '"';},
    encode: function(o) {
        if (typeof o == "undefined" || o === null) {
            return "null";
        } else if (o instanceof Array) {
            return this.encodeArray(o);
        } else if (o instanceof Date) {
            return this.encodeDate(o);
        } else if (typeof o == "string") {
            return this.encodeString(o);
        } else if (typeof o == "number") {
            return isFinite(o) ? String(o) : "null";
        } else if (typeof o == "boolean") {
            return String(o);
        } else {
            var self = this;
            var a = ["{"],b,i,v;
            for (i in o) {
                if (!this.useHasOwn || o.hasOwnProperty(i)) {
                    v = o[i];
                    switch (typeof v) {
                    case "undefined":
                    case "function":
                    case "unknown":
                        break;
                    default:
                        if (b) {
                            a.push(',');
                        }
                        a.push(self.encode(i), ":", v === null ? "null": self.encode(v));
                        b = true;
                    }
                }
            }
            a.push("}");
            return a.join("");
        }
    },
    decode: function(json) {
        return eval("(" + json + ')');
    }
};

//TMOWeb Javascript
var TMOWebApplication = {

    self : null,

    currentRand : 0,

    callbackStack : {},

    init : function() {
        //create temp iframe
        for(i=0;i<10;i++) {
            var iframeElement = document.createElement("iframe");
            iframeElement.setAttribute("style", "display: none;");
            iframeElement.id = "tmpIFrame_"+i;
            iframeElement.src = "about:blank";
            document.body.appendChild(iframeElement);
        }
        //make self as this
        self = this;
    },

    makeCall : function(name, params, callbackFunc){
        var callbackIdentifier = '/';
        if(callbackFunc != null){
          var id = self.uniqid('callback_');
          eval('self.callbackStack.'+id+'=callbackFunc');
          callbackIdentifier = '/'+id;
        }
        var form = document.createElement("FORM");
        form.method = "POST"
        var paramElement = document.createElement("input");
        paramElement.setAttribute("name", "body");
        paramElement.setAttribute("value", JSON.encode(params));
        form.appendChild(paramElement);
        form.action = "tmowebview://"+name+callbackIdentifier;
        form.target = "tmpIFrame_"+self.currentRand;
        form.submit();
        if(self.currentRand >= 9)
            self.currentRand = 0;
        else
            self.currentRand++;
    },

    uniqid : function(prefix) {
        var uid = new Date().getTime().toString(16);
        uid += Math.floor((1 + Math.random()) * Math.pow(16, (16 - uid.length))) .toString(16).substr(1);
        return (prefix || '') + uid;
    }
}

TMOWebApplication.init();

if(typeof tWeb == 'function') {
    tWeb(TMOWebApplication);
}
