
function makeAllEditable(logID) {
  console.log("makeAllEditable(" + logID + ")");
  var emailID = "h5[id='employee-log-email-" + logID + "']";
  var empNumID = "h5[id='employee-log-employee-number-" + logID + "']";
  var empRoleID = "h5[id='employee-log-role-" + logID + "']";

  $(emailID).editable({
      closeOnEnter : true, // Whether or not pressing the enter key should close the editor (default false)
      event : 'click', // The event that triggers the editor (default dblclick)
      emptyMessage : 'Employee Email', // HTML that will be added to the editable element in case it gets empty (default false)
      callback : function( data ) {
        console.log(data);
        if( data.content ) {
          var el = data.$el;
          var id = logID;
          var hash = {};
          hash["employee_log"] = {}
          hash["employee_log"]["email"] = data.content;
          var str =  "/employee_log/" + id + "/update.json";
          callAjax('post', str, hash)
        }
        if( data.fontSize ) {
            // the font size has changed

        }
          // data.$el gives you a reference to the element that was edited
      }
  });

  $(empNumID).editable({
      closeOnEnter : true, // Whether or not pressing the enter key should close the editor (default false)
      event : 'click', // The event that triggers the editor (default dblclick)
      emptyMessage : 'Employee Number', // HTML that will be added to the editable element in case it gets empty (default false)
      callback : function( data ) {
          console.log('$(empNumId).callback( data -> ');
          console.log(data);
          if( data.content ) {
            var el = data.$el;
            var id = logID;
            var hash = {};
            hash["employee_log"] = {}
            hash["employee_log"]["employee_number"] = data.content;
            var str =  "/employee_log/" + id + "/update.json";
            callAjax('post', str, hash);
          }
          if( data.fontSize ) { }
      }
  });



  var roleSelectVal = 'ep-' + logID;
  function callR() {
    console.log("callR()");
    console.log(roleSelectVal);
    $(roleSelectVal)
      .blur(function () {
          console.log("second clicked");
          var input = $(roleSelectVal)
          var data = input.val();
          if ((data === null)  ||  (data === "") || (!data)) {
            console.log("data is null");
            input.remove();
            var label = $(empRoleID);
            label.show();
          } else {
            var hash = {report : {date : data}};
            console.log("calling ajax");
            callAjax('post', "/reports/" + logID + "/update", hash );
            input.remove();
            var label = $(empRoleID);
            label.text(data);
            label.show();
          }
      })
      .focusout(function(event) {
        var input = $(roleSelectVal)
          var data = input.val();
          if ((data === null)  ||  (data === "") || (!data)) {
            console.log("data is null");
            input.remove();
            var label = $(empRoleID);
            label.show();
          } else {
            var hash = {report : {date : data}};
            console.log("calling ajax");
            callAjax('post', "/reports/" + logID + "/update", hash );
            input.remove();
            var label = $(empRoleID);
            label.text(data);
            label.show();
          }
      });
  }

  $(empRoleID).on('click', function () {

      console.log("clicked");

      callR();
      var input = $('<select id="'+ roleSelectVal + '"><option>Admin</option><option>Manager</option><option>Employee</option></input>');
      var label = $(empRoleID)
      input.width(label.width);
      input.height(label.height);
      input.css("margin", label.css("margin"));
      input.on('keyup', function (e) {
          if( e.keyCode == 13 ) {
              $(input).blur();
          }
      });
      label.after(input);
      label.hide();
  });
}