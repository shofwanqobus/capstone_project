const {
    addUser,
    getAllUsers,
    getUserById,
    editUserById,
    deleteUserById,
} = require('./handler');

const routes = [
    //Add user for login
    {
        method: 'POST',
        path: '/users',
        handler: addUser,
    },

    //get all user
    {
        method: 'GET',
        path: '/users',
        handler: getAllUsers,
    },

    //get user for login by id
    {
        method: 'GET',
        path: '/users/{id}',
        handler: getUserById,
    },

    //edit user for by id
    {
        method: 'PUT',
        path: '/users/{id}',
        handler: editUserById,
    },

    //delete user for login
    {
        method: 'DELETE',
        path: '/users/{id}',
        handler: deleteUserById,
    },
]; module.exports = routes;