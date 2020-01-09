<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Custom CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/hari/assets/extra-libs/multicheck/multicheck.css">
<link href="${pageContext.request.contextPath}/resources/hari/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">

<!--이 페이지에서만 쓰는  ckeditor 필수 제이쿼리 지우지 마세요! -->
<script src="https://cdn.ckeditor.com/4.13.1/standard-all/ckeditor.js"></script>

<!-- Page wrapper  -->
<!-- ============================================================== -->
<div class="page-wrapper">
	<!-- ============================================================== -->
	<!-- Bread crumb and right sidebar toggle -->
	<!-- ============================================================== -->
	<div class="page-breadcrumb">
		<div class="row">
			<div class="col-12 d-flex no-block align-items-center">
				<h4 class="page-title">양식 등록</h4>
				<div class="ml-auto text-right"></div>
			</div>
		</div>
	</div>
	
	<div class="container-fluid">
		<!-- ============================================================== -->
		<!-- Start Page Content -->
		<!-- ============================================================== -->
		<div class="row" >
			<div class="col-12">
				<div class="container">
					<!--form 태그 시작 -->
					<form action="" method="POST">
						<div class="row">
							<!-- input 태그 -->
							<div class="col-md-12">
									<input type="text" class="form-control" id="signFormName" name="signFormName" placeholder="양식명" style="width:93%; display: inline;">
									<button type="submit" class="btn btn-success" style="display: inline-block;">등록</button>
							</div>
						</div><!-- row 끝 -->
						<!-- ck 에디터 form -->
						<textarea name="signFormContent" id="signFormContent" rows="10" cols="80">
							양식을 붙여주세요.(워드,엑셀 붙여넣기 가능 / html 태그 입력 시 오른쪽 상단 소스 클릭)
						</textarea>
						<script>
							CKEDITOR.replace('signFormContent', {
								// 도구 모음 정의: https://ckeditor.com/docs/ckeditor4/latest/features/toolbar
								// 기본적으로 CDN의 전체 사전 설정은 필요 이상의 기능을 제공합니다.
								// The full preset from CDN which we used as a base provides more features than we need.
								// 또한 기본적으로 3줄 도구 모음이 제공됩니다.
								// Also by default it comes with a 3-line toolbar. Here we put all buttons in two rows.
								toolbar: [{
									name: 'clipboard',
									items: ['PasteFromWord', '-', 'Undo', 'Redo']
								},
								{
									name: 'basicstyles',
									items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
								},
								{
									name: 'links',
									items: ['Link', 'Unlink']
								},
								{
									name: 'paragraph',
									items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
								},
								{
									name: 'insert',
									items: ['Table']
								},
								{
									name: 'editing',
									items: ['Scayt']
								},
								'/',
		
								{
									name: 'styles',
									items: ['Format', 'Font', 'FontSize']
								},
								{
									name: 'colors',
									items: ['TextColor', 'BGColor', 'CopyFormatting']
								},
								{
									name: 'align',
									items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
								},
								{
									name: 'document',
									items: ['Print', 'PageBreak', 'Source']
								}],
		
								// Since we define all configuration options here, let's instruct CKEditor to not load config.js which it does by default.
								// One HTTP request less will result in a faster startup time.
								// For more information check https://ckeditor.com/docs/ckeditor4/latest/api/CKEDITOR_config.html#cfg-customConfig

			
								// Enabling extra plugins, available in the full-all preset: https://ckeditor.com/cke4/presets
								extraPlugins: 'colorbutton,font,justify,print,tableresize,pastefromword,liststyle,pagebreak',
			
								// Make the editing area bigger than default.
								height: 600,
								width: 940
							});
						</script>
						<!-- ck 에디터 form 끝 -->
					</form>
				</div><!-- container -->
			</div><!-- col-12 끝 -->
		</div><!-- row 끝 -->
	</div><!-- container-fluid 끝 -->
</div>
<!-- End Page wrapper  -->
<!-- this page js -->
<script src="${pageContext.request.contextPath}/resources/hari/assets/extra-libs/multicheck/jquery.multicheck.js"></script>

	<!--전자 결재 모달 -->
	<div id="add-new-event" class="modal modal-wide fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1>결재양식 선택</h1>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>

				<div class="modal-body">
					<form onsubmit="return false;">
						<section>
							<div></div>
						</section>
					</form>
					<div></div>
				</div>
				<div class="modal-body">
					<form></form>
					<div></div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<a href="javascript:void(0)" data-toggle="modal" data-target="#add"
						class="btn m-t-20 btn-info btn-block waves-effect waves-light">
						<i class="ti-plus"></i> 인증번호 받기
					</a>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- 전자 결재 모달 끝 -->