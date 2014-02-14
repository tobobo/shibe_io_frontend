module.exports = {
    options: {
      key: process.env.SHIBE_AWS_ACCESS_KEY_ID,
      secret: process.env.SHIBE_AWS_SECRET_ACCESS_KEY,
      bucket: process.env.SHIBE_AWS_BUCKET,
      region: process.env.SHIBE_AWS_REGION,
      gzip: true,
      headers: {
        // Two Year cache policy (1000 * 60 * 60 * 24 * 730)
        //"Cache-Control": "max-age=630720000, public",
        //"Expires": new Date(Date.now() + 63072000000).toUTCString()
      }
    },
    deploy: {
      upload: [
        {
          // make sure this document is newer than the one on S3 and replace it
          src: 'dist/**/*',
          rel: 'dist/',
        },
      ]
    }
};
