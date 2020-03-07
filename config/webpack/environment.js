const { environment } = require('@rails/webpacker');

module.exports = environment

const webpack = require('webpack');

environment.plugins.append(
    'Provide',

    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        Popper: ['popper.js', 'default'],
        test: /\.(svg|eot|woff|ttf|svg|woff2)$/,
        use: [
            {
                loader: 'file-loader',
                options: {
                    name: "[path][name].[ext]"
                }
            }
        ]
    })
);