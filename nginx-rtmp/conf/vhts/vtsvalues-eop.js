// vts values EndOfPage, change properties after page has been loaded

function updatetimedate() {
  var mday = (new Date()).toString().split(' ').splice(0);
  mday = mday[0];
  var mdate = (new Date()).toString().split(' ').splice(1,4).join(' ');
  document.title = mday + ", " + mdate + " :NOC: nginx VTS Monitor";
}

// change the title of the page to suit your needs
// document.title = "Your company name, NOC: nginx Vhost Traffic Status Monitor";

// change the title of the page to suit your needs and include a clock
// updatetimedate();
// setInterval(updatetimedate, 10000);
