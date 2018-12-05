$(document).ready(function () {
    (function ($) {
        $.fn.gdocsViewer = function (options) {

            var settings = {
                width: '100%',
                height: '650'
            };

            if (options) {
                $.extend(settings, options);
            }

            return this.each(function () {
                try {
                    var file = $(this).attr('href');
                    $(this).after(function () {
                        return '<iframe src="https://docs.google.com/viewer?embedded=true&url=' + encodeURIComponent(file) + '" width="' + settings.width + '" height="' + settings.height + '" style="border: none;margin : 0 auto; display : block;"></iframe>';
                    })
                } catch (e) { }
            });
        };
    })(jQuery);
});