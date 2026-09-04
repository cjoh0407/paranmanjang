<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<title>BoardList</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- Header -->
			<div class="row">
				<div class="col">
					<nav class="navbar navbar-expand-lg navbar-light bg-light">
						<div class="container-fluid">
							<a class="navbar-brand" href="#">Navbar</a>
							<button class="navbar-toggler" type="button"
								data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
								aria-controls="navbarNavAltMarkup" aria-expanded="false"
								aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
							<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
								<div class="navbar-nav">
									<a class="nav-link active" aria-current="page" href="#">Home</a>
									<a class="nav-link" href="#">Features</a> <a class="nav-link"
										href="#">Pricing</a> <a class="nav-link disabled">Disabled</a>
								</div>

								<!-- 관리자에게만 회원 관리 버튼 표시 -->
								<sec:authorize access="hasAuthority('ROLE_ADMIN')">
									<a href="${ctx}/member/list"
										class="btn btn-outline-primary ms-2"> 회원 관리 </a>
								</sec:authorize>
								<!-- 로그인 회원에게만 내 정보 수정 버튼 표시 -->
								<sec:authorize access="isAuthenticated()">
									<a href="${ctx}/member/modify"
										class="btn btn-outline-secondary ms-2"> 내 정보 수정 </a>

									<!-- 로그인 회원에게만 탈퇴 버튼 표시 -->
									<form action="${ctx}/member/remove" method="post"
										class="d-inline ms-2"
										onsubmit="return confirm('정말 회원 탈퇴하시겠습니까?');">
										<!-- CSRF -->
										<c:if test="${not empty _csrf}">
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}">
										</c:if>

										<button type="submit" class="btn btn-outline-danger">
											회원 탈퇴</button>
									</form>

									<a href="${ctx}/logout" class="btn btn-outline-secondary ms-2">
										로그아웃 </a>
								</sec:authorize>
							</div>
						</div>
					</nav>
				</div>
			</div>

			<!-- Search Form Card -->
			<div class="row content">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">검색</h5>
							<!-- Search Form -->
							<form name="sForm" id="sForm" action="${ctx}/board/list"
								method="post">
								<!-- CSRF -->
								<c:if test="${not empty _csrf}">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}">
								</c:if>
								<input type="hidden" name="size" value="${pageRequestDTO.size}">

								<!-- 검색 타입 (체크박스) -->
								<div class="mb-3">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" name="types"
											value="t" id="typeT"
											checked="${pageRequestDTO.isCheckType('t')}"> <label
											class="form-check-label" for="typeT">제목</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" name="types"
											value="c" id="typeC"
											checked="${pageRequestDTO.isCheckType('c')}"> <label
											class="form-check-label" for="typeC">내용</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" name="types"
											value="w" id="typeW"
											checked="${pageRequestDTO.isCheckType('w')}"> <label
											class="form-check-label" for="typeW">작성자</label>
									</div>
								</div>

								<!--/* 키워드 검색창 */-->
								<div class="input-group mb-3">
									<input type="text" name="keyword" class="form-control"
										value="${pageRequestDTO.keyword}" placeholder="검색어를 입력하세요">
									<button class="btn btn-primary" type="submit">Search</button>
									<button class="btn btn-info clearBtn" type="button">Clear</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<!-- Content List Table Card -->
			<div class="row content">
				<div class="col">
					<div class="card">
						<div class="card-header">결과</div>
						<div class="card-body">
							<h5 class="card-title">조회 범위</h5>

							<!-- Size Select Box -->
							<select class="form-select form-select-sm"
								aria-label="Small select" name="size" id="size">
								<option value="10" selected="${pageResponseDTO.size == 10}">10</option>
								<option value="30" selected="${pageResponseDTO.size == 30}">30</option>
								<option value="50" selected="${pageResponseDTO.size == 50}">50</option>
								<option value="100" selected="${pageResponseDTO.size == 100}">100</option>
							</select>

							<!-- Button Controls -->
							<div class="d-flex justify-content-between my-3">
								<button type="button" class="btn btn-danger removeBatchBtn">선택
									삭제</button>
								<button type="button" class="btn btn-primary registerBtn">Register</button>
							</div>

							<!-- Data Table -->
							<table class="table">
								<thead>
									<tr>
										<th scope="col"><input type="checkbox" id="checkAll"></th>
										<th scope="col">Bno</th>
										<th scope="col">Title</th>
										<th scope="col">Writer</th>
										<th scope="col">RegDate</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="dto" items="${pageResponseDTO.dtoList}">
									<tr>
										<td><input type="checkbox" name="bnos" class="bnos"
											value="${dto.bno}"></td>
										<th scope="row">${dto.bno}</th>
										<td>
											<!-- 상세 조회 링크 --> <a
											href="${ctx }/board/read?bno=${dto.bno}&${pageRequestDTO.link}"
											class="text-decoration-none bno-link"
											data-bno="${dto.bno}">${dto.title}</a> <span>(${dto.replyCount})</span>

											<!-- ★ 등록된 썸네일 이미지가 있다면 목록에 출력 -->
											<c:if test="${dto.boardImages != null && dto.boardImages.size() > 0}">
											<div>
											<c:forEach var="boardImage" items="${dto.boardImages}">
												<img
													style="width: 50px; height: 50px; object-fit: cover; margin-right: 5px;"
													src="${boardImage.imageUrl}"></c:forEach>
											</div>
											</c:if>
										</td>
										<td>${dto.writer}</td>
										<td>${dto.regDate}</td>
									</tr>
								</c:forEach>	
								</tbody>
							</table>
							<!-- Pagination -->
							<div class="float-end">
								<ul class="pagination flex-wrap">
									<!-- Previous -->
									<c:if test="${pageResponseDTO.prev}">
									<li class="page-item"><a
										class="page-link"
										data-page-num="${pageResponseDTO.start - 1}" href="#">Previous</a>
									</li>
									</c:if>	
									<!-- Numbers -->
									<c:forEach var="page" begin="${pageResponseDTO.start}"
                                           end="${pageResponseDTO.end}">
										<li class="page-item ${pageResponseDTO.page == page ? 'active' : ''}">
											<a class="page-link" data-page-num="${page}"
											href="javascript:void(0)">${page}</a>
										</li>
									</c:forEach>

									<!-- Next -->
									<c:if test="${pageResponseDTO.next}">
									<li class="page-item" ><a
										class="page-link"
										data-page-num="${pageResponseDTO.end + 1}" href="#">Next</a>
									</li>
									</c:if>
								</ul>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Footer -->
		<div class="row footer">
			<div class="row fixed-bottom" style="z-index: -100">
				<footer class="py-1 my-1">
					<p class="text-center text-muted">Footer</p>
				</footer>
			</div>
		</div>
	</div>
	<!-- Bootstrap -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
    crossorigin="anonymous">
</script>


<!-- jQuery -->
<script
    src="https://code.jquery.com/jquery-3.7.1.min.js"
    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
    crossorigin="anonymous">
</script>


<script>

<c:if test="${not empty result}"> /* result가 null 또는 빈 문자열인지 확인 */
    alert("${result}");
</c:if>


$(document).ready(function() {

    const $sForm = $("#sForm");

    const listUrl = "${ctx}/board/list";


    // 등록 버튼
    $(".registerBtn").on("click", function(e) {

        self.location = "${ctx}/board/register";

    });


    // 전체 선택 / 해제
    $("#checkAll").on("change", function() {

        $(".bnos").prop("checked", this.checked);

    });


    // 선택 삭제
    $(".removeBatchBtn").on("click", function(e) {

        e.preventDefault();
        e.stopPropagation();

        const $checkedBoxes = $(".bnos:checked");


        if ($checkedBoxes.length === 0) {

            alert("삭제할 항목을 하나 이상 선택해주세요.");

            return;
        }


        if (confirm("선택한 항목들을 정말 삭제하시겠습니까?")) {


            // 기존 hidden bnos 삭제
            $sForm.find(
                "input[name='bnos'][type='hidden']"
            ).remove();


            // 체크한 bno 추가
            $checkedBoxes.each(function() {

                $("<input>")
                    .attr("type", "hidden")
                    .attr("name", "bnos")
                    .val($(this).val())
                    .appendTo($sForm);

            });


            $sForm
                .attr(
                    "action",
                    "${ctx}/board/removeBatch"
                )
                .attr("method", "post")
                .submit();

        }

    });


    // 페이지 클릭
    $(".pagination").on(
        "click",
        ".page-link",
        function(e) {

            e.preventDefault();
            e.stopPropagation();


            const pageNum =
                $(this).data("pageNum");


            if (!pageNum) {
                return;
            }


            $sForm.find(
                "input[name='page']"
            ).remove();


            $("<input>")
                .attr("type", "hidden")
                .attr("name", "page")
                .val(pageNum)
                .appendTo($sForm);


            $sForm.submit();

        }
    );


    // 목록 개수 변경
    $("#size").on("change", function() {

        const size = $(this).val();

        /*
         * JSP에서는 JavaScript의
         * `${size}` 문법이 JSP EL과 충돌할 수 있기 때문에
         * 문자열 연결 방식을 사용
         */
        self.location =
            listUrl + "?size=" + size;

    });


    // 검색 초기화
    $(".clearBtn").on("click", function(e) {

        e.preventDefault();
        e.stopPropagation();


        const size =
            $("#size").val() || 10;


        self.location =
            listUrl + "?size=" + size;

    });

});

</script>
</body>
</html>