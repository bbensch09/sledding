console.log("calendard.js has loaded.")
$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        // put your options and callbacks here
        header: {
        	left: 'prev,next today',
        	right: 'month,basicWeek,listMonth'
        },
        defaultView: 'listMonth',
        editable: true,
        // production web client key
        // googleCalendarApiKey: '525026694989-7chbsc4pip6p24mkqi71inh13oc8n1gk.apps.googleusercontent.com',
        // old api key
        googleCalendarApiKey: 'AIzaSyCCXnv6RXbEy9NZ_x6huXAX7bhiB81ODKE',
        eventSources: [{
	        	googleCalendarId: 'brian@snowschoolers.com'
	        }
        ]
        // defaultView: 'basicWeek',
        // events: ['test 1', 'test2'].
        // resources: [
        // {id:1, title: "Title1"}
        // ]
    });

});