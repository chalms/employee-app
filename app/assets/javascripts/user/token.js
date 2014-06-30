// Copyright 2014 Andrew Chalmers


Token = function(jObj) {
    this.jObj = jObj;
    this.setValues(this.jObj);
}

Token.prototype.setPreFilter = function() {
    $(function() {
        $.ajaxSetup({
            beforeSend: function(xhr) {
                if (sessionStorage.auth !== "" && sessionStorage.auth !== "undefined") {
                    xhr.setRequestHeader("AUTHORIZATION", sessionStorage.auth);
                }
            }
        })
    })
}


Token.prototype.hasToken = function() {
    if (this.token.token !== null) {
        return true;
    } else {
        return false;
    }
};

Token.prototype.counter = function() {
    setInterval(function() {
        decrementTtl();
    }, 1E3)
};


Token.prototype.decrementTtl = function() {
    this.ttl = parseInt(this.ttl);
    this.ttl = this.ttl - 1;
    if (this.ttl <= 10) renewToken();
}

Token.prototype.setValues = function(params) {
    this.token = params["api_session_token"]["token"];
    sessionStorage.auth = this.token; 
    var _this = this;
    
    $(function() {
        $.ajaxPrefilter(function(newOpts, oldOpts, xhr) {
            xhr.setRequestHeader("AUTHORIZATION", _this.token);
        });
    });
    if (params["api_session_token"]["ttl"]) {
         this.ttl = parseInt(this.ttl);
    }
}

Token.prototype.renewToken = function() {
		var _this = this; 
    $(function() {
        $.ajax({
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
            },
            data: _this.getJSON(),
            url: "http://localhost:3000/api/sessions",
            type: "POST",
            success: function(b) {
                var items = {};
                setValues(b);
            },
            error: function(c, d, e) {
                return _this.set("error", "" + d + ": " + e);
            }
        });
    });
}
