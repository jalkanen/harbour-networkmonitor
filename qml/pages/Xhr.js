
var lastCall;
var lastinout;

function formatString(inout) {
    var str = "In: "+format(inout.in)+"\nOut: "+format(inout.out);
    var now = new Date().getTime();

    if( lastinout ) {
        var tdiff   = now - lastCall;
        var indiff  = Math.round(1000 * (inout.in  - lastinout.in) / tdiff);
        var outdiff = Math.round(1000 * (inout.out - lastinout.out) / tdiff);

        str += "\n\nIn: "+format(indiff)+"/s";
        str += "\nOut: "+format(outdiff)+"/s";
    }

    lastinout = inout;
    lastCall = now;
    return str;
}

/**
 *  Get the number of input and output bytes for eth0
 */
function readBytes(callback) {
    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var pattern = /(\w+):\s*(\d+)\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)/
            var inout = { in: 0, out: 0 };

            var lines = xhr.responseText.split(/\n/);
            var i;

            //console.log("Lines ="+lines.length);

            for( i = 0; i < lines.length; i++ ) {
                var m0 = lines[i].match(pattern);

                if( m0 && m0[1] !== 'lo' ) {
                    inout.in += parseInt(m0[2]);
                    inout.out += parseInt(m0[3]);
                    //console.log("Found "+m0[1]+", in "+m0[2]+", out "+m0[3])
                } else {
                    //console.log("Ignored "+m0);
                }
            }

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
    if( number < 8000 ) {
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

