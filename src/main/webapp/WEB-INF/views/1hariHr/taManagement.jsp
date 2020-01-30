<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Custom CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/hari/assets/extra-libs/multicheck/multicheck.css">
<link href="${pageContext.request.contextPath}/resources/hari/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">

<!-- moment js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.js"></script>

<!-- Page wrapper  -->
<!-- ============================================================== -->
<div class="page-wrapper">
	<!-- ============================================================== -->
	<!-- Bread crumb and right sidebar toggle -->
	<!-- ============================================================== -->
	<div class="page-breadcrumb">
		<div class="row">
			<div class="col-12 d-flex no-block align-items-center">
				<h4 class="page-title"> 근태관리 </h4>
				<div class="ml-auto text-right"></div>
			</div>
		</div>
	</div>
	<!-- ============================================================== -->
	<!-- End Bread crumb and right sidebar toggle -->
	<!-- ============================================================== -->
	
	<!-- Container fluid  -->
	<!-- ============================================================== -->
	<div class="container-fluid" style ="margin-top: 3%;">
		<!-- ============================================================== -->
		<!-- Start Page Content -->
		<!-- ============================================================== -->
		<div class="row">
			<div class="col-12">

				<!-- 사원 근태관리 테이블 -->
				<div class="card">
					<div class="card-body" style ="border-radius:10px; box-shadow :3px 3px #999999;  border: 2px groove #999999;">
						<h5 class="card-title"></h5>
						<div class="table-responsive">
							<form id="taTable" name="taTable" method="post" enctype="multipart/form-data">
								<table id="zero_config" class="table table-striped table-bordered">
									<thead>
										<tr>
											<th>
												<select id="selectMonth"></select>
											</th>
											<th id="days" colspan="5">
											</th>
										</tr>
										<tr>
											<th>사번</th>
											<th>사원</th>
											<th>부서</th>
											<th>출근시간</th>
											<th>퇴근시간</th>
											<th>퇴근처리</th>
										</tr>
									</thead>
									<tbody id="taBody">
										
									</tbody>
									<tfoot>
									</tfoot>
								</table>
							</form>
						</div>

					</div>
				</div>
				<!--데이터 테이블 끝 -->

			</div>
		</div>
		<!-- ============================================================== -->
		<!-- End PAge Content -->
		<!-- ============================================================== -->
		<!-- ============================================================== -->
		<!-- Right sidebar -->
		<!-- ============================================================== -->
		<!-- .right-sidebar -->
		<!-- ============================================================== -->
		<!-- End Right sidebar -->
		<!-- ============================================================== -->
	</div>
	<!-- ============================================================== -->
	<!-- End Container fluid  -->
	<!-- ============================================================== -->

	<!-- ============================================================== -->
</div>
<!-- ============================================================== -->
<!-- End Page wrapper  -->
<!-- ============================================================== -->
<!-- this page js -->
<script src="${pageContext.request.contextPath}/resources/hari/assets/extra-libs/multicheck/datatable-checkbox-init.js"></script>
<script src="${pageContext.request.contextPath}/resources/hari/assets/extra-libs/multicheck/jquery.multicheck.js"></script>
<script src="${pageContext.request.contextPath}/resources/hari/assets/extra-libs/DataTables/datatables.min.js"></script>

<script>
	$(function() {
		let startWork = ""; // 출근시간 처리를 위한 변수
		let leaveWork = ""; // 퇴근시간 처리를 위한 변수
		let today = moment().format("YYYY-MM-DD"); // 오늘 날짜
		let curMonth = moment().format("YYYY-MM"); // 현재 월
		let curDay = moment().date(); // 현재 일
		let setDate = "";
		
		getTaList(today); // 페이지 로딩 후 근태목록 가져오기
		getThreeMonth(); // 근태목록을 가져온 후 직전 2개월까지 선택할 수 있도록 하는 함수 호출

		function getThreeMonth() { // 직전 2개월 (총 3개월)을 선택할 수 있는 함수
			// daysMonth SelectBox
			let preMonth = moment().add(-1, "month").format("YYYY-MM"); // 1달 전
			let pastMonth = moment().add(-2, "month").format("YYYY-MM"); // 2달 전
	
			let month = "";
			month += '<option value="' + curMonth + '" selected>' + curMonth + '</option>' // 현재 월을 기본적으로 선택이 되도록
					+ '<option value="' + preMonth + '">' + preMonth + '</option>'
					+ '<option value="' + pastMonth + '">' + pastMonth + '</option>';
			$('#selectMonth').append(month); // selectBox에 넣기
			
			let selectedMonth = moment($('#selectMonth').val()).month(); // 선택되어 있는 현재 월('2020-01')에서 월(01)만 추출
			
			selectMonth(selectedMonth);
			
			$('#selectMonth').change(function() { // 선택 월이 바뀌는 경우
				selectedMonth = moment($('#selectMonth').val()).month(); // 선택한 월에서 월만 추출
				$('#days').empty(); // 해당 월 일자를 비워주고
				selectMonth(selectedMonth); // 해당 월 일자를 생성하는 함수 호출
			})
		}
		
		function getTaList(setDate) { // 근태목록 가져오기
			$.ajax({
				url: "${pageContext.request.contextPath}/ajax/getTaList.hari",
				type: "post",
				data : { "setDate" : setDate },
				dataType: "json",
				success: function(TaList) {
					let empTaList = "";
					let count = 0;
					
					for (var i = 0; i < TaList.length; i++) {
						if (count == 0) {
							empTaList += '<tr>'
											+ '<td>' + TaList[i].empNum + '</td>' // 사번
											+ '<td>' + TaList[i].empName + ' ' + TaList[i].rankName +'</td>' // 이름, 직급
											+ '<td>' + TaList[i].teamName + '</td>'; // 부서
							if (TaList[i].taDate != null && TaList[i].taDate != '0000-00-00 00:00:00') {
								empTaList += '<td>' + TaList[i].taName + ' (' + TaList[i].taDate + ')</td>'; // 출근, 출근시간
							} else if (TaList[i].taDate == null && TaList[i].taDate != '0000-00-00 00:00:00'){
								empTaList += '<td>' + TaList[i].taName + ' (출근시간 기록없음)</td>'; // 출근, 출근시간
							} else if (TaList[i].taDate == '0000-00-00 00:00:00') {
								empTaList += '';
							}
							count++;
						} else {
							if (TaList[i].empNum == TaList[i-1].empNum && TaList[i].taCode == 5) { // 퇴근이 아닌 결근처리가 되어있을 경우
								empTaList += '<td>' + TaList[i].taName + ' (' + TaList[i].taDate + ')</td>'
											+ '<td><button type="button" class="editEmpTa btn btn-success"><i class="fa fa-edit"></i> 퇴근처리</button></td>' // 결근일 경우 퇴근처리 버튼 생성
										+ '</tr>';
								count = 0;
							} else { // 결근이 아닌 경우
								if (TaList[i].taDate != null && TaList[i].taDate != '0000-00-00 00:00:00') {
									empTaList += '<td>' + TaList[i].taName + ' (' + TaList[i].taDate + ')</td>';
								} else if (TaList[i].taDate == null && TaList[i].taDate != '0000-00-00 00:00:00'){
									empTaList += '<td>' + TaList[i].taName + ' (퇴근시간 기록없음)</td>';
								} else if (TaList[i].taDate == '0000-00-00 00:00:00') {
									empTaList += '<td colspan="2">' + TaList[i].taName + '</td>';
								}
									empTaList += '<td></td>' // 결근이 아닐 경우 퇴근처리 버튼을 만들지 않음
											+ '</tr>';
								count = 0;
							}
						}
					}
					$('#taBody').append(empTaList);
					/* 비동기 데이터 호출 후 DataTable 호출 */
					$('#zero_config').DataTable();
					
					setEmpTa(setDate);
				}
			});
		}

		function setEmpTa(setDate) { // 퇴근처리하기
			$('.editEmpTa').click(function() {
				let tr = $(this).closest('tr'); // 나와 조상요소 중 첫번째 tr //.parent() 바로 상위요소 찾기
				let empNum = tr.children().html(); // 나와 조상요소 중 첫번째 tr의 자식의 값
				let startWorkTime = tr.children().eq(3).html(); // 해당 사원의 출근기록시간 받기
				// let leaveWorkTime = tr.children().eq(4).html(); // 해당 사원의 결근기록시간 받기
				
				startWork = moment(startWorkTime, "YYYY-MM-DD HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");
				leaveWork = moment(startWork, "YYYY-MM-DD HH:mm:ss").add(9, "hours").format("YYYY-MM-DD HH:mm:ss");
				
				$.ajax({
					url: "${pageContext.request.contextPath}/ajax/setEmpTa.hari",
					data: 
						{
							"empNum" : empNum,
							 "taDate" : leaveWork,
							 "setDate" : setDate
						},
					type: "post",
					dataType: "json",
					success: function() {
						$('#taBody').empty();
						getTaList(setDate);
					},
					error : function(xhr){
						console.log(xhr.status);
						console.log('setEmpTa ajax error');
					}
				})
			})
		}

		function selectMonth(selectedMonth, setDate) {
			let daysMonth = moment(selectedMonth).month(selectedMonth).daysInMonth(); // 해당 월의 일수를 구해서 변수에 선언
			let days = "";

			for (var i = 0; i < daysMonth; i++) {
				if (setDate == "") { // 오늘 날짜로 페이지를 들어왔을 때
					if (moment(curMonth).month() != selectedMonth) {
						days += '<span class="click"> ' + (i + 1) + ' </span>'; // 1일은 0이기 때문에 +1
					} else {
						if (curDay != (i + 1)) {
							days += '<span class="click"> ' + (i + 1) + ' </span>'; // 1일은 0이기 때문에 +1
						} else {
							days += '<span class="click" style="color: red;"> ' + (i + 1) + ' </span>'; // 1일은 0이기 때문에 +1
						}
					}
				} else { // 클릭 이후에 페이지에 들어올 때
					if (moment(setDate).month() != selectedMonth) {
						days += '<span class="click"> ' + (i + 1) + ' </span>'; // 1일은 0이기 때문에 +1
					} else {
						if (moment(setDate).date() != (i + 1)) {
							days += '<span class="click"> ' + (i + 1) + ' </span>'; // 1일은 0이기 때문에 +1
						} else {
							days += '<span class="click" style="color: red;"> ' + (i + 1) + ' </span>'; // 1일은 0이기 때문에 +1
						}
					}
				}
			}
			$('#days').append(days);

			$('.click').click(function() { // 해당 날짜(일)을 선택했을 때
				setDate = $('#selectMonth').val() + '-' + $(this).text().trim(); // 해당 날짜를 연-월-일로 선언
				$('#taBody').empty();
				$('#days').empty();
				selectMonth(moment($('#selectMonth').val()).month(), setDate); // 해당 월의 일수 재조정
				getTaList(setDate); // 해당 날짜 근태목록 가져오기
			})
		}
	})
	
</script>