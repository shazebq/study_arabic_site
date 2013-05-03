$(document).ready(function() { 
    CKEDITOR.config.toolbar = [
        [ 'Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink' ]
    ];


    CKEDITOR.config.removePlugins = 'elementspath'

    CKEDITOR.config.linkShowAdvancedTab = false;
    CKEDITOR.config.linkShowTargetTab = false;
});

