const moment = require('moment');

// type
// 0: text, 1: typing, 2: untyping, 3: leave, 4: enter

function formatMessage(id, username, text, time) {
    return {
        id,
        username,
        text,
        time: time
    };
}

module.exports = formatMessage;