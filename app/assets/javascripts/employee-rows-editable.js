
function makeAllEditable(logID) {
  console.log("makeAllEditable(" + logID + ")");
  var emailID = "h5[id='employee-log-email-" + logID + "']";
  var empNumID = "h5[id='employee-log-employee-number-" + logID + "']";
  var empRoleID = "h5[id='employee-log-role-" + logID + "']";

  $(emailID).editable({
      closeOnEnter : true,
      event : 'click',
      emptyMessage : 'Employee Email',
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
        if( data.fontSize ) {}
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

  $(empRoleID).on('click', function () {
      console.log("clicked");
      var input = $('<select id="'+ roleSelectVal + '"><option>Admin</option><option>Manager</option><option>Employee</option></input>');
      var label = $(empRoleID)
      input.width(label.width);
      input.height(label.height);
      input.css("margin", label.css("margin"));
       input.blur(function () {
        console.log("on.blur()");
        var data = input.val();
        console.log("-> data");
        console.log(data);
        var hash = {report : {date : data}};
        callAjax('post', "/reports/" + logID + "/update", hash );
        input.remove();
        var label = $('#employee-role-sum');
        label.text(data);
        label.show();
      });
      label.after(input);
      label.hide();
  });
}
