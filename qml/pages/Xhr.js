
var lastCall;
var lastinout;

function delta(t0,t1,time) {
    return Math.round(1000* Math.abs(t1-t0)/time);
}

function diff(inout) {
    var diff = { in: 0, out: 0, wlanIn: 0, wlanOut: 0, totalIn: 0, totalOut: 0 }
    var now = new Date().getTime();

    if( lastinout ) {
        var tdiff = now - lastCall;
        diff.in       = delta(inout.in,lastinout.in,tdiff);
        diff.out      = delta(inout.out,lastinout.out,tdiff);
        diff.wlanIn   = delta(inout.wlanIn,lastinout.wlanIn,tdiff);
        diff.wlanOut  = delta(inout.wlanOut,lastinout.wlanOut,tdiff);
        diff.totalIn  = delta(inout.totalIn,lastinout.totalIn,tdiff);
        diff.totalOut = delta(inout.totalOut,lastinout.totalOut,tdiff);
    }

    lastinout = inout;
    lastCall = now;

    return diff;
}

/**
 *  Get the number of input and output bytes for eth0
 */
function readBytes(callback) {
    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var pattern = /(\w+):\s*(\d+)\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)/
            var inout = { in: 0, out: 0, wlanIn: 0, wlanOut: 0 };

            var lines = xhr.responseText.split(/\n/);
            var i;

            //console.log("Lines ="+lines.length);

            for( i = 0; i < lines.length; i++ ) {
                var m0 = lines[i].match(pattern);

                if( m0 && m0[1] !== 'lo' ) {
                    if( m0[1] === 'wlan' ) {
                        inout.wlanIn += parseInt(m0[2]);
                        inout.wlanOut += parseInt(m0[3]);
                    } else {
                        inout.in += parseInt(m0[2]);
                        inout.out += parseInt(m0[3]);
                    }
                    //console.log("Found "+m0[1]+", in "+m0[2]+", out "+m0[3])
                } else {
                    //console.log("Ignored "+m0);
                }
            }

            inout.totalIn  = inout.wlanIn + inout.in;
            inout.totalOut = inout.wlanOut + inout.out;

            callback(inout);
        }
    }
    xhr.open("GET", "/proc/net/dev");
    xhr.send();
}

/**
 *  Formats bytes in a sane way
 */
function format(number) {
    if( number < 2000 ) {
        return number + " B";
    } else if( number < 900000 ) {
        return Math.round(number / 1024) + " kB";
    } else if( number < 100000000 ) {
        return Math.round( 10 * number / (1024*1024))/10 + " MB";
    } else if( number < 1000000000 ){
        return Math.round( number / (1024*1024) ) + " MB";
    } else {
        return Math.round( number / (1024*1024*1024) ) + " GB";
    }
}

