module.exports = {
    options: {
        args: ["--verbose"],
        exclude: [".git*","*.scss","node_modules", ".htaccess"],
        recursive: true
    },
    staging: {
        options: {
            src                 : "dist/",
            dest                : "/var/www/myht.gummii.co.uk/htdocs",
            host                : process.env.MYHT_STAGING, // export this environment variable in .bashrc
            syncDestIgnoreExcl  : true
        }
    },
    production: {
        options: {
            src                 : "dist/",
            dest                : "/var/htwww/??",
            host                : process.env.MYHT_PRODUCTION, // export this environment variable in .bashrc
            syncDestIgnoreExcl  : true
        }
    }
};
