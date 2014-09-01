module.exports = {
  benjiLocal: {
      options: {
          branch: 'develop',
          create: false
      }
  },
  staging: {
    options: {
      branch: 'develop',
      create: false
    }
  },
  production: {
    options: {
      branch: 'master',
      create: false
    }
  }
};