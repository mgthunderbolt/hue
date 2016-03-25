## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

<%!
from desktop import conf
from desktop.lib.i18n import smart_unicode
from django.utils.translation import ugettext as _

home_url = url('desktop.views.home')
from desktop.conf import USE_NEW_EDITOR
if USE_NEW_EDITOR.get():
  home_url = url('desktop.views.home2')
%>

<%def name="is_selected(selected)">
  %if selected:
    class="active"
  %endif
</%def>

<%def name="get_nice_name(app, section)">
  % if app and section == app.display_name:
    - ${app.nice_name}
  % endif
</%def>

<%def name="get_title(title)">
  % if title:
    - ${smart_unicode(title)}
  % endif
</%def>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta charset="utf-8">
  <title>Hue ${get_nice_name(current_app, section)} ${get_title(title)}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/x-icon" href="${ static('desktop/art/favicon.ico') }" />
  <meta name="description" content="">
  <meta name="author" content="">

  <link href="//fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300ita‌​lic,400italic,500,500italic,700,700italic,900italic,900" rel="stylesheet">
  <link href="${ static('desktop/ext/css/bootplus.css') }" rel="stylesheet">
  <link href="${ static('desktop/ext/css/font-awesome.min.css') }" rel="stylesheet">
  <link href="${ static('desktop/css/hue3.css') }" rel="stylesheet">
  <link href="${ static('desktop/css/huenification.css') }" rel="stylesheet">
  <link href="${ static('desktop/ext/css/fileuploader.css') }" rel="stylesheet">

  <style type="text/css">
    % if conf.CUSTOM.BANNER_TOP_HTML.get():
      body {
        display: none;
        visibility: hidden;
        padding-top: ${str(int(padding[:-2]) + 30) + 'px'};
      }
      .banner {
        height: 40px;
        width: 100%;
        padding: 0;
        position: fixed;
        top: 0;
        background-color: #F9F9F9;
        z-index: 1033;
      }
      .navigator {
        top: 30px!important;
      }
      .navbar-fixed-top {
        top: 58px!important;
      }
      % if current_app == "sqoop":
      .top-bar {
        top: 58px!important;
      }
      % endif

      % if current_app == "spark":
      .search-bar {
        top: 58px!important;
      }
      .show-assist {
        top: 110px!important;
      }
      % endif

    % else:
      body {
        display: none;
        visibility: hidden;
        padding-top: ${padding};
      }
    % endif
  </style>

  <script type="text/javascript" charset="utf-8">

    // jHue plugins global configuration
    jHueFileChooserGlobals = {
      labels: {
        BACK: "${_('Back')}",
        SELECT_FOLDER: "${_('Select this folder')}",
        CREATE_FOLDER: "${_('Create folder')}",
        FOLDER_NAME: "${_('Folder name')}",
        CANCEL: "${_('Cancel')}",
        FILE_NOT_FOUND: "${_('The file has not been found')}",
        UPLOAD_FILE: "${_('Upload a file')}",
        FAILED: "${_('Failed')}"
      },
      user: "${ user.username }"
    };

    jHueHdfsTreeGlobals = {
      labels: {
        CREATE_FOLDER: "${_('Create folder')}",
        FOLDER_NAME: "${_('Folder name')}",
        CANCEL: "${_('Cancel')}"
      }
    };

    jHueTableExtenderGlobals = {
      labels: {
        GO_TO_COLUMN: "${_('Go to column:')}",
        PLACEHOLDER: "${_('column name...')}"
      }
    };

    jHueTourGlobals = {
      labels: {
        AVAILABLE_TOURS: "${_('Available tours')}",
        NO_AVAILABLE_TOURS: "${_('None for this page.')}",
        MORE_INFO: "${_('Read more about it...')}",
        TOOLTIP_TITLE: "${_('Demo tutorials')}"
      }
    };

    LeafletGlobals = {
      layer: '${ leaflet['layer'] |n,unicode }',
      attribution: '${ leaflet['attribution'] |n,unicode }'
    };

  </script>

  <!--[if lt IE 9]>
  <script type="text/javascript">
    if (document.documentMode && document.documentMode < 9){
      location.href = "${ url('desktop.views.unsupported') }";
    }
  </script>
  <![endif]-->

  <script type="text/javascript">
    // check if it's a Firefox < 7
    var _UA = navigator.userAgent.toLowerCase();
    for (var i = 1; i < 7; i++) {
      if (_UA.indexOf("firefox/" + i + ".") > -1) {
        location.href = "${ url('desktop.views.unsupported') }";
      }
    }

    // check for IE document modes
    if (document.documentMode && document.documentMode < 9){
      location.href = "${ url('desktop.views.unsupported') }";
    }
  </script>

  <script src="${ static('desktop/js/hue.utils.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/jquery-2.1.1.min.js') }"></script>
  <script src="${ static('desktop/js/jquery.migration.js') }"></script>
  <script src="${ static('desktop/js/jquery.filechooser.js') }"></script>
  <script src="${ static('desktop/js/jquery.selector.js') }"></script>
  <script src="${ static('desktop/js/jquery.delayedinput.js') }"></script>
  <script src="${ static('desktop/js/jquery.rowselector.js') }"></script>
  <script src="${ static('desktop/js/jquery.notify.js') }"></script>
  <script src="${ static('desktop/js/jquery.titleupdater.js') }"></script>
  <script src="${ static('desktop/js/jquery.horizontalscrollbar.js') }"></script>
  <script src="${ static('desktop/js/jquery.tablescroller.js') }"></script>
  <script src="${ static('desktop/js/jquery.tableextender.js') }"></script>
  <script src="${ static('desktop/js/jquery.scrollup.js') }"></script>
  <script src="${ static('desktop/js/jquery.tour.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.cookie.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.total-storage.min.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.placeholder.min.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.dataTables.1.8.2.min.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.nicescroll.min.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/floatlabels.min.js') }"></script>
  <script src="${ static('desktop/js/jquery.datatables.sorting.js') }"></script>
  <script src="${ static('desktop/ext/js/bootstrap.min.js') }"></script>
  <script src="${ static('desktop/ext/js/bootstrap-better-typeahead.min.js') }"></script>
  <script src="${ static('desktop/ext/js/fileuploader.js') }"></script>
  <script src="${ static('desktop/js/popover-extra-placements.js') }"></script>

  <script type="text/javascript" charset="utf-8">

    //Add CSRF Token to all XHR Requests
    var xrhsend = XMLHttpRequest.prototype.send;
    XMLHttpRequest.prototype.send = function (data) {
      this.setRequestHeader('X-CSRFToken', $.cookie('csrftoken'));
      return xrhsend.apply(this, arguments);
    }

    $.fn.dataTableExt.sErrMode = "throw";

    // sets global assistHelper TTL
    $.totalStorage('hue.cacheable.ttl', ${conf.CUSTOM.CACHEABLE_TTL.get()});

    $(document).ready(function () {
      // forces IE's ajax calls not to cache
      if ($.browser.msie) {
        $.ajaxSetup({ cache: false });
      }

      // prevents framebusting and clickjacking
      if (self == top){
        $("body").css({
          'display': 'block',
          'visibility': 'visible'
        });
      }
      else {
        top.location = self.location;
      }

      %if conf.AUTH.IDLE_SESSION_TIMEOUT.get() > -1 and not skip_idle_timeout:
      var idleTimer;
      function resetIdleTimer() {
        clearTimeout(idleTimer);
        idleTimer = setTimeout(function () {
          // Check if logged out
          $.get('/desktop/debug/is_idle');
        }, (${conf.AUTH.IDLE_SESSION_TIMEOUT.get()} * 1000) + 1000);
      }

      $(document).on('mousemove', resetIdleTimer);
      $(document).on('keydown', resetIdleTimer);
      $(document).on('click', resetIdleTimer);
      resetIdleTimer();
      %endif

      $("input, textarea").placeholder();
      $(".submitter").keydown(function (e) {
        if (e.keyCode == 13) {
          $(this).closest("form").submit();
        }
      }).change(function () {
          $(this).closest("form").submit();
      });

      $(".navbar .nav-tooltip").tooltip({
        delay: 0,
        placement: "bottom"
      });

      $("[rel='tooltip']").tooltip({
        delay: 0,
        placement: "bottom"
      });

      $("[rel='navigator-tooltip']").tooltip({
        delay: 0,
        placement: "bottom"
      });

      % if 'jobbrowser' in apps:
      var JB_CHECK_INTERVAL_IN_MILLIS = 30000;
      var checkJobBrowserStatusIdx = window.setTimeout(checkJobBrowserStatus, 10);

      function checkJobBrowserStatus(){
        $.getJSON("/${apps['jobbrowser'].display_name}/?format=json&state=running&user=${user.username}", function(data){
          if (data != null && data.jobs != null){
            if (data.jobs.length > 0){
              $("#jobBrowserCount").removeClass("hide").text(data.jobs.length);
            }
            else {
              $("#jobBrowserCount").addClass("hide");
            }
          }
          checkJobBrowserStatusIdx = window.setTimeout(checkJobBrowserStatus, JB_CHECK_INTERVAL_IN_MILLIS);
        }).fail(function () {
          window.clearTimeout(checkJobBrowserStatusIdx);
        });
      }
      % endif

      function openDropdown(which, timeout){
        var _this = which;
        var _timeout = timeout!=null?timeout:800;
        if ($(".navigator").find("ul.dropdown-menu:visible").length > 0) {
          _timeout = 10;
        }
        window.clearTimeout(closeTimeout);
        openTimeout = window.setTimeout(function () {
          $(".navigator li.open").removeClass("open");
          $(".navigator .nav-pills li.dropdown > ul.dropdown-menu").hide();
          $("[rel='navigator-tooltip']").tooltip("hide");
          _this.find("ul.dropdown-menu:eq(0)").show();
        }, _timeout);
      }

      var openTimeout, closeTimeout;
      $(".navigator ul.nav li.dropdown").on("click", function(){
        openDropdown($(this), 10);
      });
      $(".navigator ul.nav li.dropdown").hover(function () {
        openDropdown($(this));
      },
      function () {
        window.clearTimeout(openTimeout);
        closeTimeout = window.setTimeout(function () {
          $(".navigator li.open").removeClass("open");
          $(".navigator li a:focus").blur();
          $(".navigator").find("ul.dropdown-menu").hide();
        }, 1000);
      });

      function showSubmenu(menuElement) {
        $(".tooltip").remove();
        menuElement.data("lastShown", (new Date()).getTime())
        menuElement.show();
      }

      $(".navigator ul.nav li.dropdown-submenu a").on("mouseenter", function () {
        showSubmenu($(this).siblings(".dropdown-menu"));
      });

      $(".navigator ul.nav li.dropdown-submenu a img").on("mouseenter", function () {
        showSubmenu($(this).parent().siblings(".dropdown-menu"));
      });

      $(".navigator ul.nav li.dropdown-submenu").on("mouseenter", function () {
        $(this).siblings().find(".dropdown-menu").hide();
        showSubmenu($(this).find(".dropdown-menu"));
      });

      $(".navigator ul.nav li.dropdown-submenu").on("mouseleave", function () {
        var _lastShown = $(this).find(".dropdown-menu").data("lastShown");
        if (_lastShown == null || (new Date()).getTime() - _lastShown > 300) {
          var _el = $(this);
          _el.hideTimeout = window.setTimeout(function () {
            window.clearTimeout(_el.hideTimeout);
            _el.find(".dropdown-menu").hide();
          }, 50);
        }
      });

      var _skew = -1;
      $("[data-hover]").on("mouseover", function(){
        var _this = $(this);
        _skew = window.setTimeout(function(){
          _this.attr("src", _this.data("hover"));
        }, 3000);
      });

      $("[data-hover]").on("mouseout", function(){
        $(this).attr("src", $(this).data("orig"));
        window.clearTimeout(_skew);
      });
    });
  </script>
</head>
<body>

% if conf.CUSTOM.BANNER_TOP_HTML.get():
  <div id="banner-top" class="banner">
    ${ conf.CUSTOM.BANNER_TOP_HTML.get() | n,unicode }
  </div>
% endif

<%
  def count_apps(apps, app_list):
    count = 0
    found_app = ""
    for app in app_list:
      if app in apps:
       found_app = app
       count += 1
    return found_app, count
%>
% if not skip_topbar:
<div class="navigator">
  <div class="pull-right">

##     <ul class="nav nav-pills">
##             <li class="dropdown">
##               <a href="#" class="navbar-btn login-btn" data-toggle="dropdown">
##                 <span>SQL Developer</span>&nbsp;
##                 <b class="caret"></b>
##               </a>
##               <ul class="dropdown-menu" role="menu" >
##                 <li><a href="javascript: void(0);" >Persona A</a></li>
##
##                 <li><a href="javascript: void(0);" >Persona B</a></li>
##
##                 <li><a href="javascript: void(0);" >System Admin</a></li>
##
##                 <li><a href="javascript: void(0);" >SQL Developer</a></li>
##               </ul>
##             </li>
##             <li >
##               <a href="#" class="navbar-btn login-btn" data-toggle="dropdown" >
##                 <span class="fa fa-cog" aria-hidden="true"></span>
##               </a>
##             </li>
##           </ul>

    <ul class="nav nav-pills">
      <li class="dropdown">
      <a title="${ _('Administration') }" href="index.html#" data-toggle="dropdown" class="dropdown-toggle"><span class="hideable">SQL Developer&nbsp;</span><b class="caret"></b></a>
      <ul class="dropdown-menu pull-right">
          <li><a href="javascript: void(0);" >Persona A</a></li>

                <li><a href="javascript: void(0);" >Persona B</a></li>

                <li><a href="javascript: void(0);" >System Admin</a></li>

                <li><a href="javascript: void(0);" >SQL Developer</a></li>
      </ul>
    </li>
      <li >
              <a href="#" class="navbar-btn login-btn" data-toggle="dropdown" >
                <span class="fa fa-cog" aria-hidden="true"></span>
              </a>
            </li>
    </ul>


##   % if user.is_authenticated() and section != 'login':
##   <ul class="nav nav-pills">
##     <li class="divider-vertical"></li>
##     % if 'filebrowser' in apps:
##     <li class="hide1380"><a title="${_('Manage HDFS')}" rel="navigator-tooltip" href="/${apps['filebrowser'].display_name}"><i class="fa fa-file"></i>&nbsp;${_('File Browser')}&nbsp;</a></li>
##     <li class="hideMoreThan1380"><a title="${_('File Browser')}" rel="navigator-tooltip" href="/${apps['filebrowser'].display_name}"><i class="fa fa-file"></i></a></li>
##     % endif
##     % if 'jobbrowser' in apps:
##     <li class="hide1380"><a title="${_('Manage jobs')}" rel="navigator-tooltip" href="/${apps['jobbrowser'].display_name}"><i class="fa fa-list-alt"></i>&nbsp;${_('Job Browser')}&nbsp;<span id="jobBrowserCount" class="badge badge-warning hide" style="padding-top:0;padding-bottom: 0"></span></a></li>
##     <li class="hideMoreThan1380"><a title="${_('Job Browser')}" rel="navigator-tooltip" href="/${apps['jobbrowser'].display_name}"><i class="fa fa-list-alt"></i></a></li>
##     % endif
##     <li class="dropdown">
##       <a title="${ _('Administration') }" rel="navigator-tooltip" href="index.html#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cogs"></i>&nbsp;<span class="hideable">${user.username}&nbsp;</span><b class="caret"></b></a>
##       <ul class="dropdown-menu pull-right">
##         <li>
##           <a href="${ url('useradmin.views.edit_user', username=user.username) }"><i class="fa fa-key"></i>&nbsp;&nbsp;
##             % if is_ldap_setup:
##               ${_('View Profile')}
##             % else:
##               ${_('Edit Profile')}
##             % endif
##           </a>
##         </li>
##         % if user.is_superuser:
##           <li><a href="${ url('useradmin.views.list_users') }"><i class="fa fa-group"></i>&nbsp;&nbsp;${_('Manage Users')}</a></li>
##         % endif
##       </ul>
##     </li>
##     % if 'help' in apps:
##     <li><a title="${_('Documentation')}" rel="navigator-tooltip" href="/help"><i class="fa fa-question-circle"></i></a></li>
##     % endif
##     <li id="jHueTourFlagPlaceholder"></li>
##     <li><a title="${_('Sign out')}" rel="navigator-tooltip" href="/accounts/logout/"><i class="fa fa-sign-out"></i></a></li>
##   </ul>
##   % else:
##   <ul class="nav nav-pills" style="margin-right: 40px">
##     <li id="jHueTourFlagPlaceholder"></li>
##   </ul>
##   % endif

  </div>
    <div class="pull-left hamburger hamburger--arrow" type="button">
    <span class="hamburger-box">
      <span class="hamburger-inner"></span>
    </span>
    </div>

    <a class="brand nav-tooltip pull-left" title="${_('About Hue')}" rel="navigator-tooltip" href="/about">
      <svg class="logo" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1184.06 218.11">
            <path d="M1002.48,57.55a123.44,123.44,0,0,0-32.71,4.36,84.34,84.34,0,0,0-14.08,5.24,21.26,21.26,0,0,0-18-9.6H915.23v167.2h43.61v-86.8c0-16.88,2.9-23.46,8.73-29.3s14.74-8.72,26.8-8.72h18.81V57.55h-10.72" transform="translate(-18.8 -8.14)"></path>
            <path d="M206.23,8.14H183.79v196A19.42,19.42,0,0,0,190,218.82a21,21,0,0,0,15,5.93h22.44v-196a19.45,19.45,0,0,0-6.23-14.64,21,21,0,0,0-15-5.92" transform="translate(-18.8 -8.14)"></path>
            <path d="M320.44,190.8c25.93,0,34.14-27.2,34.14-50.23S346.37,90,320.44,90s-33.82,27.55-33.82,50.57S294.5,190.8,320.44,190.8Zm0-137.3C369.68,53.5,397,85.93,397,140c0,53.89-27.28,86.23-76.48,86.23-50.17,0-76.21-32.34-76.21-86.23C244.28,85.93,270.32,53.5,320.48,53.5Z" transform="translate(-18.8 -8.14)"></path>
            <path d="M95,190.8c-25.93,0-33.82-27.2-33.82-50.23S69,90,95,90c13.47,0,22.13,7.47,27.37,17.84h45.31C158.54,73.33,133.47,53.5,95,53.5,44.83,53.5,18.8,85.93,18.8,140c0,53.89,26,86.23,76.2,86.23,38.48,0,63.49-19.82,72.59-54.21H137.87s-8,.22-12.5,4.47C117.52,183.92,111.15,190.8,95,190.8Z" transform="translate(-18.8 -8.14)"></path>
            <path d="M552.16,63.6q-5.92-6.23-15.27-6.23H515.08V162.14q0,15-9,21.81a33.56,33.56,0,0,1-40.65,0q-9-6.85-9-21.81V78.55a20.9,20.9,0,0,0-5.92-15q-5.91-6.23-15.27-6.23H413.36v97.22c0,29.5,8.3,47.77,23.05,58s31,13.7,49.3,13.7,34.59-3.54,49.31-13.7,23.05-28.46,23.05-58v-76A20.91,20.91,0,0,0,552.16,63.6Z" transform="translate(-18.8 -8.14)"></path>
            <path d="M724.35,14.06a21,21,0,0,0-15-5.92H687.52v62A61,61,0,0,0,645.74,53.5c-44.54,0-70.28,32.43-70.28,86.53,0,53.89,26.44,86.23,77.42,86.23,49.77,0,77.46-32.08,77.68-85.55h0v-112A19.44,19.44,0,0,0,724.35,14.06ZM652.83,190.8c-26.35,0-34.36-27.21-34.36-50.23S626.48,90,652.83,90c26.19,0,34.59,27.22,34.69,50.15v0.55h0C687.49,163.7,679.13,190.8,652.83,190.8Z" transform="translate(-18.8 -8.14)"></path>
            <path d="M899.17,130.3a21.3,21.3,0,0,1-2.25,9.77,21.92,21.92,0,0,1-3.68,5.18,19.41,19.41,0,0,1-14.64,6.23H790c1.12,19.9,11.27,39.32,33.19,39.32,16.18,0,22.56-6.89,30.41-14.28,4.5-4.24,12.49-4.47,12.49-4.47h29.73c-9.11,34.39-34.12,54.21-72.6,54.21C773,226.26,747,193.92,747,140c0-54.1,26-86.54,76.2-86.54,38.48,0,63.55,19.84,72.65,54.35a114.86,114.86,0,0,1,3.28,19.9ZM823.18,90c-18.06,0-30,13.36-31.34,29.25h62.9C854.64,103.37,840.79,90,823.18,90Z" transform="translate(-18.8 -8.14)"></path>
            <path d="M1159,99.81q0-22.23-18.07-34.58Q1123.5,53.51,1088.6,53.5q-31.17,0-48,14.2a49.39,49.39,0,0,0-17.7,32.23h41.76a16.69,16.69,0,0,1,10.22-10,45.63,45.63,0,0,1,15.58-2.48,50.83,50.83,0,0,1,17.76,2.78c6.33,2.19,9.66,5.86,9.66,12,0,6.62-9.12,12.79-27.41,15.16-22,2.86-39.33,5.22-55.13,16.83-10.15,7.45-16.53,21.11-16.53,38.4,0,18.53,5.75,31.6,16.82,39.83,9.87,7.35,25.89,13.62,51.83,13.62,23.26,0,40.71-5.08,52.34-12.9,12.05-8.23,18.83-17.71,19.22-35.06V99.81Zm-46.85,81.29q-10,9.7-27.42,9.7c-3.62,0-15.07-.81-19.83-5.38-3.47-3.33-5.61-6.74-5.61-12.79a17,17,0,0,1,4.35-11.59c6.14-6.5,12.89-7.42,27.41-10.61,9.62-2.11,21.42-5.65,27.49-9.05V154C1118.56,165.28,1118.81,174.65,1112.17,181.1Z" transform="translate(-18.8 -8.14)"></path>
            <path d="M1186.06,54.58c10,0,16.8,7.71,16.8,17.24s-6.89,17.25-16.8,17.25-16.62-7.77-16.62-17.25S1176,54.58,1186.06,54.58Zm0,31.71c7.89,0,13.89-6.51,13.89-14.47s-6.06-14.52-13.89-14.52-13.84,6.44-13.84,14.52C1172.22,79.72,1178.16,86.29,1186.06,86.29Zm0.25-12h-3.66V81.8H1179V61.91h6.63c5.12,0,7.46,1.58,7.46,6,0,3.1-.76,4.93-3.16,5.94l3.6,8h-3.91Zm-3.66-3h3.73c2.21,0,3.22-.76,3.22-3.16s-1.27-3.16-3.92-3.16h-3v6.31Z" transform="translate(-18.8 -8.14)"></path>
          </svg>
    </a>
    % if user.is_authenticated() and section != 'login':
##      <ul class="nav nav-pills pull-left">
##        <li><a title="${_('My documents')}" rel="navigator-tooltip" href="${ home_url }" style="padding-bottom:2px!important"><i class="fa fa-home" style="font-size: 19px"></i></a></li>
##        <%
##          query_apps = count_apps(apps, ['beeswax', 'impala', 'rdbms', 'pig', 'jobsub', 'spark']);
##        %>
##        % if query_apps[1] > 1:
##        <li class="dropdown oozie">
##          <a title="${_('Query data')}" rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">Query Editors <b class="caret"></b></a>
##          <ul role="menu" class="dropdown-menu">
##            % if 'beeswax' in apps:
##              <%
##                from desktop.conf import USE_NEW_EDITOR
##              %>
##              % if USE_NEW_EDITOR.get():
##              <li><a href="${ url('notebook:editor') }?type=hive"><img src="${ static(apps['beeswax'].icon_path) }" class="app-icon"/> ${_('Hive')}</a></li>
##              % else:
##              <li><a href="/${apps['beeswax'].display_name}"><img src="${ static(apps['beeswax'].icon_path) }" class="app-icon"/> ${_('Hive')}</a></li>
##              % endif
##            % endif
##            % if 'impala' in apps:
##              % if USE_NEW_EDITOR.get(): ## impala requires beeswax anyway
##              <li><a href="${ url('notebook:editor') }?type=impala"><img src="${ static(apps['impala'].icon_path) }" class="app-icon"/> ${_('Impala')}</a></li>
##              % else:
##              <li><a href="/${apps['impala'].display_name}"><img src="${ static(apps['impala'].icon_path) }" class="app-icon"/> ${_('Impala')}</a></li>
##              % endif
##            % endif
##            % if 'rdbms' in apps:
##              % if USE_NEW_EDITOR.get():
##              <li><a href="/${apps['rdbms'].display_name}"><img src="${ static(apps['rdbms'].icon_path) }" class="app-icon"/> ${_('DB Query')}</a></li>
##              % else:
##              <li><a href="/${apps['rdbms'].display_name}"><img src="${ static(apps['rdbms'].icon_path) }" class="app-icon"/> ${_('DB Query')}</a></li>
##              % endif
##            % endif
##            % if 'pig' in apps:
##              % if USE_NEW_EDITOR.get() and False:
##              <li><a href="${ url('notebook:editor') }?type=pig"><img src="${ static(apps['pig'].icon_path) }" class="app-icon"/> ${_('Pig')}</a></li>
##              % else:
##              <li><a href="/${apps['pig'].display_name}"><img src="${ static(apps['pig'].icon_path) }" class="app-icon"/> ${_('Pig')}</a></li>
##              % endif
##            % endif
##            % if 'jobsub' in apps:
##              <li><a href="/${apps['jobsub'].display_name}"><img src="${ static(apps['jobsub'].icon_path) }" class="app-icon"/> ${_('Job Designer')}</a></li>
##            % endif
##          </ul>
##        </li>
##        % elif query_apps[1] == 1:
##           <li><a href="/${apps[query_apps[0]].display_name}">${apps[query_apps[0]].nice_name}</a></li>
##        % endif
##        % if 'beeswax' in apps:
##         <%
##           from desktop.conf import USE_NEW_EDITOR
##         %>
##         % if USE_NEW_EDITOR.get():
##          <% from desktop.models import Document2, Document %>
##          <% notebooks = [d.content_object.to_dict() for d in Document.objects.get_docs(user, Document2, extra='notebook') if not d.content_object.is_history] %>
##          % if not notebooks:
##            <li>
##              <a title="${_('Notebook')}" rel="navigator-tooltip" href="${ url('notebook:new') }">${_('Notebooks')}</a>
##            </li>
##          % else:
##            <li class="dropdown">
##              <a title="${_('Notebook')}" rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">
##                ${_('Notebooks')} <b class="caret"></b>
##              </a>
##              <ul role="menu" class="dropdown-menu">
##                <li><a href="${ url('notebook:new') }"><i class="fa fa-fw fa-plus" style="vertical-align: middle"></i>${_('Notebook')}</a></li>
##                <li><a href="${ url('notebook:notebooks') }"><i class="fa fa-fw fa-tags" style="vertical-align: middle"></i>${_('Notebooks')}</a></li>
##                <li class="divider"></li>
##                % for notebook in notebooks:
##                  <li>
##                    <a href="${ url('notebook:notebook') }?notebook=${ notebook['id'] }">
##                      <i class="fa fa-file-text-o" style="vertical-align: middle"></i> ${ notebook['name'] |n }
##                    </a>
##                  </li>
##                % endfor
##              </ul>
##            </li>
##           % endif
##         % endif
##       % endif
##        <%
##          data_apps = count_apps(apps, ['metastore', 'hbase', 'sqoop', 'zookeeper']);
##        %>
##        % if data_apps[1] > 1:
##        <li class="dropdown">
##          <a title="${_('Manage data')}" rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">Data Browsers <b class="caret"></b></a>
##          <ul role="menu" class="dropdown-menu">
##            % if 'metastore' in apps:
##              <li><a href="/${apps['metastore'].display_name}"><img src="${ static(apps['metastore'].icon_path) }" class="app-icon"/> ${_('Metastore Tables')}</a></li>
##            % endif
##            % if 'hbase' in apps:
##              <li><a href="/${apps['hbase'].display_name}"><img src="${ static(apps['hbase'].icon_path) }" class="app-icon"/> ${_('HBase')}</a></li>
##            % endif
##            % if 'sqoop' in apps:
##              <li><a href="/${apps['sqoop'].display_name}"><img src="${ static(apps['sqoop'].icon_path) }" class="app-icon"/> ${_('Sqoop Transfer')}</a></li>
##            % endif
##            % if 'zookeeper' in apps:
##              <li><a href="/${apps['zookeeper'].display_name}"><img src="${ static(apps['zookeeper'].icon_path) }" class="app-icon"/> ${_('ZooKeeper')}</a></li>
##            % endif
##          </ul>
##        </li>
##        % elif data_apps[1] == 1:
##          <li><a href="/${apps[data_apps[0]].display_name}">${apps[data_apps[0]].nice_name}</a></li>
##        % endif
##        % if 'oozie' in apps:
##        <li class="dropdown oozie">
##          <a title="${_('Schedule with Oozie')}" rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">Workflows <b class="caret"></b></a>
##          <ul role="menu" class="dropdown-menu">
##            <li class="dropdown-submenu">
##              <a href="${ url('oozie:index') }"><img src="${ static('oozie/art/icon_oozie_dashboard_48.png') }" class="app-icon" /> ${_('Dashboards')}</a>
##              <ul class="dropdown-menu">
##                <li><a href="${url('oozie:list_oozie_workflows')}"><img src="${ static('oozie/art/icon_oozie_workflow_48.png') }" class="app-icon"/> ${_('Workflows')}</a></li>
##                <li><a href="${url('oozie:list_oozie_coordinators')}"><img src="${ static('oozie/art/icon_oozie_coordinator_48.png') }" class="app-icon" /> ${_('Coordinators')}</a></li>
##                <li><a href="${url('oozie:list_oozie_bundles')}"><img src="${ static('oozie/art/icon_oozie_bundle_48.png') }" class="app-icon" /> ${_('Bundles')}</a></li>
##              </ul>
##            </li>
##            <% from oozie.conf import ENABLE_V2 %>
##            % if not ENABLE_V2.get():
##            <li class="dropdown-submenu">
##              <a href="${ url('oozie:list_workflows') }"><img src="${ static('oozie/art/icon_oozie_editor_48.png') }" class="app-icon" /> ${_('Editors')}</a>
##              <ul class="dropdown-menu">
##                <li><a href="${url('oozie:list_workflows')}"><img src="${ static('oozie/art/icon_oozie_workflow_48.png') }" class="app-icon"/> ${_('Workflows')}</a></li>
##                <li><a href="${url('oozie:list_coordinators')}"><img src="${ static('oozie/art/icon_oozie_coordinator_48.png') }" class="app-icon" /> ${_('Coordinators')}</a></li>
##                <li><a href="${url('oozie:list_bundles')}"><img src="${ static('oozie/art/icon_oozie_bundle_48.png') }" class="app-icon" /> ${_('Bundles')}</a></li>
##              </ul>
##            </li>
##            % else:
##            <li class="dropdown-submenu">
##              <a href="${ url('oozie:list_editor_workflows') }"><img src="${ static('oozie/art/icon_oozie_editor_48.png') }" class="app-icon" /> ${_('Editors')}</a>
##              <ul class="dropdown-menu">
##                <li><a href="${url('oozie:list_editor_workflows')}"><img src="${ static('oozie/art/icon_oozie_workflow_48.png') }" class="app-icon"/> ${_('Workflows')}</a></li>
##                <li><a href="${url('oozie:list_editor_coordinators')}"><img src="${ static('oozie/art/icon_oozie_coordinator_48.png') }" class="app-icon" /> ${_('Coordinators')}</a></li>
##                <li><a href="${url('oozie:list_editor_bundles')}"><img src="${ static('oozie/art/icon_oozie_bundle_48.png') }" class="app-icon" /> ${_('Bundles')}</a></li>
##              </ul>
##            </li>
##            % endif
##          </ul>
##        </li>
##        % endif
##        % if 'search' in apps:
##          <% from search.search_controller import SearchController %>
##          <% controller = SearchController(user) %>
##          <% collections = controller.get_shared_search_collections() %>
##          % if not collections:
##            <li>
##              <a title="${_('Solr Search')}" rel="navigator-tooltip" href="${ url('search:index') }">${_('Search')}</a>
##            </li>
##          % else:
##            <li class="dropdown">
##              <a title="${_('Solr Search')}" rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">
##                ${_('Search')} <b class="caret"></b>
##              </a>
##              <ul role="menu" class="dropdown-menu">
##                % if 'indexer' in apps or 'search' in apps:
##                  % if 'search' in apps:
##                  <li><a href="${ url('search:new_search') }" style="height: 24px; line-height: 24px!important;"><i class="fa fa-plus" style="vertical-align: middle"></i> ${ _('Dashboard') }</a></li>
##                  <li><a href="${ url('search:admin_collections') }" style="height: 24px; line-height: 24px!important;"><i class="fa fa-tags" style="vertical-align: middle"></i>${ _('Dashboards') }</a></li>
##                  % endif
##                  % if 'indexer' in apps:
##                  <li><a href="${ url('indexer:collections') }" style="height: 24px; line-height: 24px!important;"><i class="fa fa-database" style="vertical-align: middle"></i> ${ _('Indexes') }</a></li>
##                  % endif
##                  <li class="divider"></li>
##                % endif
##                % for collection in collections:
##                  <li>
##                    <a href="${ url('search:index') }?collection=${ collection.id }">
##                      <img src="${ static(controller.get_icon(collection.name)) }" class="app-icon"/> ${ collection.name }
##                    </a>
##                  </li>
##                % endfor
##              </ul>
##            </li>
##          % endif
##        % endif
##        % if 'security' in apps:
##          <% from security.conf import HIVE_V1, HIVE_V2, SOLR_V2 %>
##          <li class="dropdown">
##            <a title="${_('Hadoop Security')}" rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">Security <b class="caret"></b></a>
##            <ul role="menu" class="dropdown-menu">
##              % if HIVE_V1.get():
##              <li><a href="${ url('security:hive') }">&nbsp;<img src="/static/metastore/art/icon_metastore_48.png" class="app-icon"></img>&nbsp;&nbsp;${_('Sentry Tables')}</a></li>
##              % endif
##              % if HIVE_V2.get():
##              <li><a href="${ url('security:hive2') }">&nbsp;<img src="/static/metastore/art/icon_metastore_48.png" class="app-icon"></img>&nbsp;&nbsp;${_('Sentry Tables v2')}</a></li>
##              % endif
##              % if SOLR_V2.get():
##              <li><a href="${ url('security:solr') }">&nbsp;<i class="fa fa-database"></i>&nbsp;&nbsp;${_('Solr Collections')}</a></li>
##              % endif
##              <li><a href="${ url('security:hdfs') }">&nbsp;<i class="fa fa-file"></i>&nbsp;&nbsp;${_('File ACLs')}</a></li>
##            </ul>
##          </li>
##        % endif
##        % if other_apps:
##        <li class="dropdown">
##          <a href="#" data-toggle="dropdown" class="dropdown-toggle">${_('Other apps')} <b class="caret"></b></a>
##          <ul role="menu" class="dropdown-menu">
##            % for other in other_apps:
##              <li><a href="/${ other.display_name }"><img src="${ static(other.icon_path) }" class="app-icon"/> ${ other.nice_name }</a></li>
##            % endfor
##          </ul>
##        </li>
##        % endif
##      </ul>
   % endif

</div>
% endif


% if is_demo:
  <ul class="side-labels unstyled">
    <li class="feedback"><a href="javascript:showClassicWidget()"><i class="fa fa-envelope-o"></i> ${_('Feedback')}</a></li>
  </ul>

  <!-- UserVoice JavaScript SDK -->
  <script>(function(){var uv=document.createElement('script');uv.type='text/javascript';uv.async=true;uv.src='//widget.uservoice.com/8YpsDfIl1Y2sNdONoLXhrg.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(uv,s)})()</script>
  <script>
  UserVoice = window.UserVoice || [];
  function showClassicWidget() {
    UserVoice.push(['showLightbox', 'classic_widget', {
      mode: 'feedback',
      primary_color: '#338cb8',
      link_color: '#338cb8',
      forum_id: 247008
    }]);
  }
  </script>
% endif

<div id="jHueNotify" class="alert hide">
    <button class="close">&times;</button>
    <span class="message"></span>
</div>

