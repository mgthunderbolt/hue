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
  from desktop.views import commonheader, commonfooter, commonshare, commonimportexport, _ko
  from django.utils.translation import ugettext as _
%>
<%namespace name="actionbar" file="actionbar.mako" />

${ commonheader(_("Notebooks"), "spark", user, "60px") | n,unicode }


<div class="navbar navbar-inverse navbar-fixed-top" data-bind="visible: ! $root.isPlayerMode()">
  <div class="navbar-inner">
    <div class="container-fluid">
      <div class="nav-collapse">
        <ul class="nav editor-nav">
          <li class="currentApp">
              <a href="${ url('notebook:editor') }?type=${ editor_type }" title="${ _('%s Editor') % editor_type.title() }" style="cursor: pointer">
              % if editor_type == 'impala':
                <img src="${ static('impala/art/icon_impala_48.png') }" class="app-icon" />
                ${ _('Impala Queries') }
              % elif editor_type == 'rdbms':
                <img src="${ static('rdbms/art/icon_rdbms_48.png') }" class="app-icon" />
                ${ _('SQL Queries') }
              % elif editor_type == 'pig':
                <img src="${ static('pig/art/icon_pig_48.png') }" class="app-icon" />
                ${ _('Pig Scripts') }
              % elif editor_type in ('beeswax', 'hive'):
                <img src="${ static('beeswax/art/icon_beeswax_48.png') }" class="app-icon" />
                ${ _('Hive Queries') }
              % else:
                <img src="${ static('rdbms/art/icon_rdbms_48.png') }" class="app-icon" />
                ${ _('Notebooks') }
              % endif
              </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>


<div id="editor">

<div class="container-fluid margin-top-20">
  <div class="card card-small">
  <%actionbar:render>
    <%def name="search()">
      <input id="filterInput" type="text" class="input-xlarge search-query" placeholder="${_('Search for name, description, etc...')}">
    </%def>

    <%def name="actions()">
      <div class="btn-toolbar" style="display: inline; vertical-align: middle">
        <a data-bind="click: function(e){ atLeastOneSelected() ? copy(e) : void(0) }, css: {'btn': true, 'disabled': ! atLeastOneSelected()}">
          <i class="fa fa-files-o"></i> ${ _('Copy') }
        </a>

        <a data-bind="click: function() { atLeastOneSelected() ? $('#deleteNotebook').modal('show') : void(0) }, css: {'btn': true, 'disabled': ! atLeastOneSelected() }">
          <i class="fa fa-times"></i> ${ _('Delete') }
        </a>

        <a class="share-link btn" rel="tooltip" data-placement="bottom" style="margin-left:20px" data-bind="click: function(e){ oneSelected() ? prepareShareModal(e) : void(0) },
          attr: {'data-original-title': '${ _ko("Share") } ' + name},
          css: {'disabled': ! oneSelected(), 'btn': true}">
          <i class="fa fa-users"></i> ${ _('Share') }
        </a>

        <a data-bind="click: function() { atLeastOneSelected() ? exportDocuments() : void(0) }, css: {'btn': true, 'disabled': ! atLeastOneSelected() }">
          <i class="fa fa-download"></i> ${ _('Export') }
        </a>
      </div>
    </%def>

    <%def name="creation()">
      <a href="${ url('notebook:new') }" class="btn"><i class="fa fa-plus-circle"></i> ${ _('Create') }</a>
      <a data-bind="click: function() { $('#import-documents').modal('show'); }" class="btn">
        <i class="fa fa-upload"></i> ${ _('Import') }
      </a>
    </%def>
  </%actionbar:render>


  <table id="notebookTable" class="table datatables">
    <thead>
      <tr>
        <th width="1%"><div data-bind="click: selectAll, css: {hueCheckbox: true, 'fa': true, 'fa-check': allSelected}" class="select-all"></div></th>
        <th>${ _('Name') }</th>
        <th>${ _('Description') }</th>
        <th>${ _('Owner') }</th>
        <th>${ _('Last Modified') }</th>
      </tr>
    </thead>
    <tbody data-bind="foreach: { data: jobs }">
      <tr>
        <td data-bind="click: $root.handleSelect" class="center" style="cursor: default" data-row-selector-exclude="true">
          <div class="hueCheckbox fa" data-bind="multiCheck: '#notebookTable', css: {'fa-check': isSelected }" data-row-selector-exclude="true"></div>
          <a data-bind="attr: { 'href': absoluteUrl }" data-row-selector="true"></a>
        </td>
        <td data-bind="text: name"></td>
        <td data-bind="text: description"></td>
        <td data-bind="text: owner"></td>
        <td data-bind="text: localeFormat(last_modified), attr: { 'data-sort-value': last_modified_ts }" data-type="date"></td>
      </tr>
    </tbody>
  </table>

  </div>
</div>


<div class="hueOverlay" data-bind="visible: isLoading">
  <!--[if lte IE 9]>
    <img src="${ static('desktop/art/spinner-big.gif') }" />
  <![endif]-->
  <!--[if !IE]> -->
    <i class="fa fa-spinner fa-spin"></i>
  <!-- <![endif]-->
</div>

<div id="submit-notebook-modal" class="modal hide"></div>

<div id="deleteNotebook" class="modal hide fade">
  <form id="deleteNotebookForm" method="POST" data-bind="submit: delete2">
    ${ csrf_token(request) | n,unicode }
    <div class="modal-header">
      <a href="#" class="close" data-dismiss="modal">&times;</a>
      <h3 id="deleteNotebookMessage">${ _('Delete the selected notebook(s)?') }</h3>
    </div>
    <div class="modal-footer">
      <a href="#" class="btn" data-dismiss="modal">${ _('No') }</a>
      <input type="submit" class="btn btn-danger" value="${ _('Yes') }"/>
    </div>
  </form>
</div>

${ commonimportexport(request) | n,unicode }


</div>


${ commonshare() | n,unicode }


<script src="${ static('desktop/ext/js/datatables-paging-0.1.js') }" type="text/javascript" charset="utf-8"></script>
<script src="${ static('desktop/ext/js/knockout.min.js') }" type="text/javascript" charset="utf-8"></script>
<script src="${ static('desktop/ext/js/knockout-mapping.min.js') }" type="text/javascript" charset="utf-8"></script>
<script src="${ static('desktop/js/ko.hue-bindings.js') }" type="text/javascript" charset="utf-8"></script>
<script src="${ static('desktop/js/share.vm.js') }"></script>

<script type="text/javascript" charset="utf-8">
  var Editor = function () {
    var self = this;

    self.jobs = ko.mapping.fromJS(${ notebooks_json | n });
    self.selectedJobs = ko.computed(function() {
      return $.grep(self.jobs(), function(job) { return job.isSelected(); });
    });
    self.isLoading = ko.observable(false);

    self.oneSelected = ko.computed(function() {
      return self.selectedJobs().length == 1;
    });
    self.atLeastOneSelected = ko.computed(function() {
      return self.selectedJobs().length >= 1;
    });
    self.allSelected = ko.observable(false);

    self.handleSelect = function(notebook) {
      notebook.isSelected(! notebook.isSelected());
    };

    self.selectAll = function() {
      self.allSelected(! self.allSelected());
      ko.utils.arrayForEach(self.jobs(), function (job) {
        job.isSelected(self.allSelected());
      });
    };

    self.datatable = null;

    self.delete2 = function() {
      $.post("${ url('notebook:delete') }", {
        "notebooks": ko.mapping.toJSON(self.selectedJobs)
      }, function() {
        window.location.reload();
        $('#deleteNotebook').modal('hide');
      }).fail(function (xhr, textStatus, errorThrown) {
        $(document).trigger("error", xhr.responseText);
      });
    };

    self.copy = function() {
      $.post("${ url('notebook:copy') }", {
        "notebooks": ko.mapping.toJSON(self.selectedJobs)
      }, function(data) {
        window.location.reload();
      }).fail(function (xhr, textStatus, errorThrown) {
        $(document).trigger("error", xhr.responseText);
      });
    };

    self.exportDocuments = function() {
      $('#export-documents').find('input[name=\'documents\']').val(ko.mapping.toJSON($.map(self.selectedJobs(), function(doc) { return doc.id(); })));
      $('#export-documents').find('form').submit();
    };

    self.prepareShareModal = function() {
      shareViewModel.setDocId(self.selectedJobs()[0].doc1_id());
      openShareModal();
    };
  }

  var viewModel;
  var shareViewModel;

  $(document).ready(function () {
    viewModel = new Editor();
    ko.applyBindings(viewModel, $("#editor")[0]);

    shareViewModel = initSharing("#documentShareModal");
    shareViewModel.setDocId(-1);

    $(document).on("showSubmitPopup", function(event, data){
      $('#submit-notebook-modal').html(data);
      $('#submit-notebook-modal').modal('show');
    });

    var oTable = $("#notebookTable").dataTable({
      "sPaginationType":"bootstrap",
      'iDisplayLength':50,
      "bLengthChange":false,
      "sDom": "<'row'r>t<'row-fluid'<'dt-pages'p><'dt-records'i>>",
      "aoColumns":[
        { "bSortable":false },
        null,
        null,
        null,
        { "sSortDataType":"dom-sort-value", "sType":"numeric" }
      ],
      "aaSorting":[
        [4, 'desc'],
        [1, 'asc' ]
      ],
      "oLanguage":{
        "sEmptyTable":"${_('No data available')}",
        "sInfo":"${_('Showing _START_ to _END_ of _TOTAL_ entries')}",
        "sInfoEmpty":"${_('Showing 0 to 0 of 0 entries')}",
        "sInfoFiltered":"${_('(filtered from _MAX_ total entries)')}",
        "sZeroRecords":"${_('No matching records')}",
        "oPaginate":{
          "sFirst":"${_('First')}",
          "sLast":"${_('Last')}",
          "sNext":"${_('Next')}",
          "sPrevious":"${_('Previous')}"
        },
        "bDestroy": true
      },
      "fnDrawCallback":function (oSettings) {
        $("a[data-row-selector='true']").jHueRowSelector();
      }
    });

    viewModel.datatable = oTable;

    $("#filterInput").keydown(function (e) {
      if (e.which == 13) {
        e.preventDefault();
        return false;
      }
    });

    $("#filterInput").keyup(function () {
      oTable.fnFilter($(this).val());
    });

    $("a[data-row-selector='true']").jHueRowSelector();
  });
</script>


${ commonfooter(request, messages) | n,unicode }
