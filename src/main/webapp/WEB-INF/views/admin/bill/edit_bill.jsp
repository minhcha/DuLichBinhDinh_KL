<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="billURL" value="/quan-tri/hoa-don/danh-sach"/>
<c:url var="editBillURL" value="/quan-tri/hoa-don/chinh-sua"/>
<c:url var="billAPI" value="/api/bill"/>
<c:url var="upload" value="/update"/>
<html>
<head>
    <title>Chỉnh sửa người dùng</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
                </li>

                <li><a href="#">Forms</a></li>
                <li class="active">Form Elements</li>
            </ul>
            <!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <c:if test="${not empty message}">
                        <div class="alert alert-${alert}">
                                ${message}
                        </div>
                    </c:if>
                    <%--@elvariable id="model" type=""--%>
                    <form:form  class="form-horizontal" role="form" id="formSubmit" enctype="multipart/form-data" modelAttribute="model">

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="userEntity">Người dùng</label>
                            <div class="col-sm-9">
                                <form:input path="userEntity" cssClass="col-xs-10 col-sm-5"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="content" class="col-sm-3 control-label no-padding-right">Ngày bắt đầu </label>
                            <div class="col-sm-9">
                                <form:textarea path="startDate" rows="5" cols="10" cssClass="form-control" id="content"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="content" class="col-sm-3 control-label no-padding-right">Tên người dùng :</label>
                            <div class="col-sm-9">
                                <form:textarea path="endDate" rows="5" cols="10" cssClass="form-control" id="content"/>
                            </div>
                        </div>

                        <form:hidden path="id" id="newId"/>
                        <div class="clearfix form-actions">
                            <div class="col-md-offset-3 col-md-9">
                                <c:if test="${not empty model.id}">
                                    <button class="btn btn-info" type="button" id="btnAddOrUpdateNew">
                                        <i class="ace-icon fa fa-check bigger-110"></i>
                                        Cập nhật hóa đơn
                                    </button>
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <button class="btn btn-info" type="button" id="btnAddOrUpdateNew">
                                        <i class="ace-icon fa fa-check bigger-110"></i>
                                        Thêm hóa đơn
                                    </button>
                                </c:if>&nbsp;
                                <button class="btn" type="reset">
                                    <i class="ace-icon fa fa-undo bigger-110"></i>
                                    Hủy
                                </button>
                            </div>
                        </div>
                    </form:form>
<%--                    <form:form method="POST"--%>
<%--                               action="${upload}"--%>
<%--                               enctype="multipart/form-data">--%>
<%--                        <table>--%>
<%--                            <tr>--%>
<%--                                <td>Select a file to upload</td>--%>
<%--                                <td><input type="file" name="files" /></td>--%>
<%--                            </tr>--%>
<%--                            <tr>--%>
<%--                                <td><input type="submit" value="Lưu hình ảnh" /></td>--%>
<%--                            </tr>--%>
<%--                        </table>--%>
<%--                    </form:form>--%>
             </div>
            </div>
        </div>
    </div>
</div>


<script>
    $('#btnAddOrUpdateNew').click(function (e) {
        e.preventDefault();
        var data = {};
        var formData = $('#formSubmit').serializeArray();
        var file = $('#thumbnail')[0].files[0];

        $.each(formData, function (i, v) {
            data[""+v.name+""] = v.value;
        });
        if (file){
            console.log(file.name);
            data[""+"thumbnail"+""] = file.name;
        }

        var id = $('#newId').val();
        if (id == "") {
            addNew(data);
        } else {
            updateNew(data);
        }
    });

    function addNew(data) {
        $.ajax({
            url: '${billAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${editBillURL}?id="+result.id+"&message=insert_success";
            },
            error: function (error) {
                window.location.href = "${billURL}?page=1&limit=2&message=error_system";
            }
        });
    }

    function updateNew(data) {
        $.ajax({
            url: '${billAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${editBillURL}?id="+result.id+"&message=update_success";
            },
            error: function (error) {
                window.location.href = "${editBillURL}?id="+result.id+"&message=error_system";
            }
        });
    }
</script>
</body>
</html>