(function ($) {

    $.fn.landing_page_forms = function () {
        return this.each(function () {
            var self = $(this);
            self.find('.header_landing-page_job-seeker').click(function () {
                self.find('.login_forms').hide();
                alert('yes');
                return false;
            });
            self.find('.header_landing-page_professional').click(function () {
                self.find('.login_forms').hide();
                alert('yes');
                return false;
            });
            self.find('.header_landing-page_employer').click(function () {
                self.find('.login_forms').hide();
                alert('yes');
                return false;
            });
        });
    };

})(jQuery);
