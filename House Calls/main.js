Parse.Cloud.define("email", function(request, response) {
var Mandrill = require('mandrill');
Mandrill.initialize('MANDRILL_KEY');
Mandrill.sendEmail({
    message: {
        text: request.params.text,
        subject: "Parse and Mandrill!",
        from_email: "allielustig@gmail.com",
        from_name: "Name",
        to: [
            {
                email: "allielustig@gmail.com",
                name: "Some Name"
            }
        ]
    },
    async: true
},{
    success: function(httpResponse) {
        response.success("email sent");
    },
    error: function(httpResponse) {

    }
});