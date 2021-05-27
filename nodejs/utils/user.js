const users = [];

// Join user to chat
function userJoin(id, socketid, userid, username, roomid) {
    const user = { id, socketid, userid, username, roomid };
    users.push(user);
    return user;
}

function getUser(id) {
    return users.find(user => user.id === id);
}

function removeUser(id) {
    const index = users.findIndex(user => user.id === id);
    if (index !== -1) {
        return users.splice(index, 1);
    }
}

function userLeave(id) {
    const index = users.findIndex(user => user.socketid === id);

    if (index !== -1) {
        return users.splice(index, 1);
    }
}

module.exports = {
    userJoin,
    getUser,
    removeUser,
    userLeave,
}