<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%-- <c:if test="${pageResponse.prev}">
	<a href="#" onclick="pageMove(${pageResponse.startPage-1})" >이전</a>
</c:if>    
 
<c:forEach begin="${pageResponse.startPage}" end="${pageResponse.endPage}" var="pageNo">
	<a href="javascript:pageMove(${pageNo})">
		<c:choose>
			<c:when test="${pageNo == pageResponse.pageNo}"><b>${pageNo}</b></c:when>
			<c:otherwise>${pageNo}</c:otherwise>
		</c:choose>
	</a>     
	&nbsp;
</c:forEach>
<c:if test="${pageResponse.next}">
	<a href="#" onclick="pageMove(${pageResponse.endPage+1})">다음</a>
</c:if> --%>

<!-- /WEB-INF/views/inc/pageNav.jsp -->

<c:if test="${pageResponse.totalPage > 1}">
    <nav class="d-flex justify-content-center mt-4">
        <ul class="pagination">

            <!-- 이전 페이지 -->
            <c:if test="${pageResponse.pageNo > 1}">
                <li class="page-item">
                    <a class="page-link" href="javascript:pageMove(${pageResponse.pageNo - 1})">&laquo;</a>
                </li>
            </c:if>

            <!-- 페이지 번호 반복 -->
            <c:forEach begin="${pageResponse.startPage}" end="${pageResponse.endPage}" var="i">
                <li class="page-item ${i == pageResponse.pageNo ? 'active' : ''}">
                    <a class="page-link" href="javascript:pageMove(${i})">${i}</a>
                </li>
            </c:forEach>

            <!-- 다음 페이지 -->
            <c:if test="${pageResponse.pageNo < pageResponse.totalPage}">
                <li class="page-item">
                    <a class="page-link" href="javascript:pageMove(${pageResponse.pageNo + 1})">&raquo;</a>
                </li>
            </c:if>

        </ul>
    </nav>
</c:if>
