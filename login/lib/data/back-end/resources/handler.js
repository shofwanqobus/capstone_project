const {
    nanoid
} = require('nanoid');

const users = require('./users');

//Add User
const addUser = (request, respond) => {
    const {
        username,
        password,
        email,
        phoneNumber,
        birthDate,
    } = request.payload;

    if (!username) {
        const response = respond.response({
            status: 'fail',
            message: 'Failed to add User. Please fill the username',
        }); response.code(400);

        return response;
    }

    if (!password) {
        const response = respond.response({
            status: 'fail',
            message: 'Failed to add User. Please fill the password',
        }); response.code(400);

        return response;
    }

    if (!email) {
        const response = respond.response({
            status: 'fail',
            message: 'Failed to add User. Please fill the email',
        }); response.code(400);

        return response;
    }

    if (!phoneNumber) {
        const response = respond.response({
            status: 'fail',
            message: 'Failed to add User. Please fill the phoneNumber',
        }); response.code(400);

        return response;
    }

    if (!birthDate) {
        const response = respond.response({
            status: 'fail',
            message: 'Failed to add User. Please fill the birthDate',
        }); response.code(400);

        return response;
    }

    const id = nanoid(16);
    const insertedAt = new Date().toISOString();
    const updatedAt = insertedAt;

    const newUsers = {
        id,
        username,
        password,
        email,
        phoneNumber,
        birthDate,
        insertedAt,
        updatedAt,
    }; users.push(newUsers);

    const isSuccess = users.filter((user) => user.id === id).length > 0;

    if (isSuccess) {
        const response = respond.response({
            status: 'success',
            message: 'User has been added',
            data: {
                userId: id,
            },
        }); response.code(201);

        return response;
    }

    const response = respond.response({
        status: 'error',
        message: 'User failed been added',
    }); response.code(500);

    return response;
}

const getAllUsers = (request, respond) => {
    const {
        username,
        email,
        phoneNumber,
    } = request.query;
    
    // Inisialasi filterisasi buku
    let filteredUsers = users;

    // Filter nama buku
    if (username !== undefined) {
        filteredUsers = filteredBooks.filter((user) => user.username.toLowerCase().Includes(username.toLowerCase()));
    }

    // Tanpa Filter
    if (!username) {
        const response = respond.response({
            status: 'success',
            data: {
                users: users.map((user) => ({
                    id: user.id,
                    username: user.username,
                    email: user.publisher,
                })),
            },
        }); response.code(200);

        return response;
    }

    const response = respond.response({
        status: 'success',
        data: {
            users: filteredUsers.map((user) => ({
                id: user.id,
                username: user.username,
                email: user.email,
            })),
        },
    }); response.code(200);

    return response;
}

const getUserById = (request, respond) => {
    const {id} = request.params;
    const user = users.filter((user) => user.id === id)[0];

    if (user !== undefined) {
        const response = respond.response({
            status: 'success',
            data: {
                user,
            },
        }); response.code(200);

        return response;
    }

    const response = respond.response({
        status: 'fail',
        message: 'User not found',
    }); response.code(404);

    return response;
}

const editUserById = (request, respond) => {
    const {id} = request.params;
    const {
        username,
        password,
        email,
        phoneNumber,
        birthDate,
    } = request.payload;

    const updatedAt = new Date().toISOString();
    const index = users.findIndex((user) => user.id === id);

    if (index !== -1) {
        if (!username) {
            const response = respond.response({
                status: 'fail',
                message: 'Failed to update user. Please fill your username',
            }); response.code(400);
            
            return response;
        }

        if (!password) {
            const response = respond.response({
                status: 'fail',
                message: 'Failed to update user. Please fill your password',
            }); response.code(400);
            
            return response;
        }

        users[index] = {
            ...users[index],
            username,
            password,
            email,
            phoneNumber,
            birthDate,
            updatedAt,
        };

        // Buku yang dipilih berhasil diperbaharui
        const response = respond.response({
            status: 'success',
            message: 'User has been updated',
        }); response.code(200);

        return response;
    }
    
    // Id tidak dapat ditemukan oleh server
    const response = respond.response({
        status: 'fail',
        message: 'Failed to update user. ID not be found',
    }); response.code(404);

    return response;
}

const deleteUserById = (request, respond) => {
    const {
        id
    } = request.params;
    
    const index = users.findIndex((user) => user.id === id);

    // Jika buku yang dipilih memiliki id
    if (index !== -1) {
        users.splice(index, 1);
        const response = respond.response({
            status: 'success',
            message: 'User has been removed',
        }); response.code(200);

        return response;
    }

    //Jika buku yang dipilih tidak memiliki id apapun
    const response = respond.response({
        status: 'fail',
        message: 'Failed to remove user. ID not be found',
    }); response.code(404);

    return response;
}

module.exports = {
    addUser,
    getAllUsers,
    getUserById,
    editUserById,
    deleteUserById,
}