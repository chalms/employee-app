$(function() {
    var tokenValue = $("meta[name='csrf-token']").attr('content');

    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': tokenValue
        }
    });

    ApiSessionToken = function() {};

    ApiSessionToken.prototype.token = null;

    ApiSessionToken.prototype.ttl = 0;

    ApiSessionToken.prototype.user = null;

    ApiSessionToken.prototype.isAlive = function() {
        return this.get("ttl") > 0;
    };

    ApiSessionToken.prototype._this = ApiSessionToken;

    ApiSessionToken.prototype.hasToken = function() {
        var token;
        token = void 0;
        token = this.get("token");
        if (token && (typeof token === "string") && (token.length > 0)) {
            return true;
        } else {
            return false;
        }
    };

    ApiSessionToken.prototype.isValid = function() {
        return this.get("hasToken") && this.get("isAlive");
    };

    ApiSessionToken.prototype.needsRefresh = function() {
        return this.get("ttl") <= 10;
    };

    ApiSessionToken.prototype.init = function() {
        return this.scheduleTtlDecrement();
    };

    ApiSessionToken.prototype.decrementTtl = function() {
        if (this.get("isAlive")) {
            this.decrementProperty("ttl");
        }
        return this.scheduleTtlDecrement();
    };

    ApiSessionToken.prototype.scheduleTtlDecrement = function() {
        callback(function() {
            return decrementTtl();
        });
        return setTimeout(callback, 1000);
    };

    ApiSessionToken.prototype.refresh = function() {
        return this.acquire(this);
    };

    ApiSessionToken.prototype.acquire = function(token) {
        var credentials, password, username;
        credentials = void 0;
        password = void 0;
        username = void 0;
        token || (token = this.create());
        credentials = {};
        username = token.get("user.username");
        password = token.get("user.password");
        if (token.get("hasToken")) {
            credentials.token = token.get("token");
        }
        if (username && password) {
            credentials.username = username;
            credentials.password = password;
        }
        $.ajax({
            dataType: "json",
            data: credentials,
            url: "http://localhost:3000/api/sessions",
            type: "POST",

            success: function(data, status, xhr) {
                token.set("token", data.api_session_token.token);
                token.set("ttl", data.api_session_token.ttl);
                if (username && password) {
                    return token.get("user").authenticated();
                }
            },
            error: function(xhr, status, error) {
                return token.set("error", "" + status + ": " + error);
            }
        });
        return token;
    };

    new ApiSessionToken();

});