const formatMessage = require('./utils/messages');
const { userJoin, getUser, removeUser, userLeave } = require('./utils/user');

const express = require('express'),
    http = require('http'),
    app = express(),

    server = http.Server(app),
    io = require('socket.io')(server);


app.get('/', (req, res) => {
    res.send(`Chat Server is running on port ${PORT}`)
});

io.on('connection', (socket) => {
    console.log("[socket] connected :" + socket.id);

    socket.on('joinRoom', ({ userid, username, roomid }) => {
        console.log("[socket] join room connect : " + roomid);

        const existedUser = getUser(`${roomid}-${userid}`);
        if (existedUser) {
            existedUser.socketid = socket.id;
        } else {
            console.log(`[socket] join ${userid} to ${roomid}`);
            const user = userJoin(`${roomid}-${userid}`, socket.id, userid, username, roomid);
            socket.join(user.id);
        }
    });

    socket.on('self', ({ userid, username }) => {
        const existedUser = getUser(`self-${userid}`);
        if (existedUser) {
            existedUser.socketid = socket.id;
        } else {
            const user = userJoin(`self-${userid}`, socket.id, userid, username, 'self');
            socket.join(user.id);
        }
    });

    socket.on('chatMessage', ({ roomid, senderid, username, receiverid, msg, timestamp }) => {
        console.log(`[socket] chat message : ${msg} by ${username}`);
        const user = getUser(`${roomid}-${receiverid}`);
        if (user) {
            io.to(user.id).emit('message', formatMessage(senderid, username, msg, timestamp));
        } else {
            io.to(`self-${receiverid}`).emit('unread', formatMessage(senderid, username, msg, timestamp));
        }
    });

    socket.on('leaveRoom', ({ roomid, userid }) => {
        const existedUser = getUser(`${roomid}-${userid}`);
        if (existedUser) {
            console.log("[socket] leaveRoom : " + userid);
            socket.leave(existedUser.id);
            removeUser(existedUser.id);
        } else {
            console.log("[socket] leaveRoom : No Found User");
        }
    });

    socket.on('disconnect', () => {
        const user = userLeave(socket.id);
        if (user) {
            console.log("[socket] offline one user");
        }
    });
});

const PORT = 8222;
server.listen(PORT, () => {
    console.log(`Node app is running on port ${PORT}`);
});
