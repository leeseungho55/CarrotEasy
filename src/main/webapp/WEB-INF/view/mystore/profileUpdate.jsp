<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>내 상점</title>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<style>
	* {
            box-sizing: border-box;
        }
        
        .container {
        	max-width: 1000px;
        	height: 700px;
        }

        #store {
            display: flex;
            width: 100%;
            max-width: 800px;
            height: 300px;
            border: 1px solid #ccc;
            background-color: #fff;
            margin: 0 auto;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .photo-all {
            flex: 1;
            display: flex;
            flex-direction: column;
            border-right: 1px solid #eee;
        }

        .photo-show {
            flex: 4;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #fafafa;
            border-bottom: 1px solid #eee;
            overflow: hidden;
        }

        .photo-show img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .photo-reg {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px;
        }

        #file-input {
            display: none;
        }

        .custom-btn {
            padding: 6px 12px;
            border: 1px solid #ddd;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border-radius: 4px;
            margin-left: 10px;
        }

        .store-info {
            flex: 2;
            padding: 20px;
        }
	
	
</style>
<body>
<div class="container">
	<div id="store">
		<div class="photo-all">
			<div class="photo-show" id="photo-preview">
				<span style="color:#aaa;">사진 등록</span>
			</div>
			<div class="photo-reg">
				<form action="/CarrotEasy/mystore/profileUpdate.do" method="post" enctype="multipart/form-data" id="upload-form">
					<label for="file-input" class="custom-btn">파일 선택</label>
					<input type="file" id="file-input" name="photo">
					<input type="submit" value="업로드" class="custom-btn">
				</form>
			</div>
		</div>
		<div class="store-info"></div>
	</div>
</div>
<script>
	$(document).ready(function() {
		
		// 파일 선택되면 미리보기
		$("#file-input").change(function(event) {
		    var file = event.target.files[0];
		    if(file) {
		        var reader = new FileReader();
		        reader.onload = function(e) {
		            $("#photo-preview").html('<img src="' + e.target.result + '" alt="사진 미리보기">');
		        }
		        reader.readAsDataURL(file);
		
		    }
		});
		
	});
</script>

</body>
</html>
