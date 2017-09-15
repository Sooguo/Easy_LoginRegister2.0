<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%String contextPath = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>登录界面</title>   
       <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webuploader.css">
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.js"> </script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/webuploader.js"> </script>
       <style type="text/css">
         #dndArea {
	         width: 100%;
	         height: 100px;
	         border-color: green;
	         border-style: solid;
          }
       </style>
       <script language="javascript">
           function getFileName(obj)
           {
             var pos = obj.value.lastIndexOf("\\")*1;
             return obj.value.substring(pos+1);
           }

            function showInfo(obj)
            {
              var filename = "文件名：" + getFileName(obj);
              document.getElementById("filename").innerText = filename;
            }
     </script>
</head>

<body style="background: url(img/backGround.jpg)">
    欢迎用户：${userName}<br/>${message} 
  <hr/>
    您的账号及密码信息为:账号：${userName}&nbsp;&nbsp;密码：${password}&nbsp;&nbsp;
  <hr/>
  <!-- 可以利用文件目录添加文件，保存到本地！ -->
  <form method="post" action="/login2version/UploadServlet" enctype="multipart/form-data">
	  选择文件上传到本地:
	  <input type="file" name="uploadFile" />
	  <input type="submit" value="上传" />
  </form>
  <hr/>
  
  <!-- 可以获取文件名字的代码 -->
  <div id="filename" style="font-size:12px; "></div><br>
  可获得文件名：<input type="file" name="file1" onChange="showInfo(this);">
  <hr/>
  
  <!--  把文件名提交到数据库 -->
  <form method="post" action="<%=request.getContextPath() %>/RegisterServlet?oprateType=userUpdate">
        账号(默认数据，不可修改！不信试试？):<input type="text" id="userName" name="userName" value="${userName}" readonly style="width:100%;hight:30px;"><br/>
        文件:<input type="text" id="fileName" name="fileName" value="" style="width:100%;hight:30px;"><br/>
	<input id="submitBtn" type="submit" value="确认">
  </form>
  
  <hr/>
  <!-- 利用拖拽添加文件 -->
  <!-- 上传文件 -->
  <div id="uploader">
  	<!-- 指定文件拖拽区域 -->
	<div id="dndArea">
		<h1 align="center">将文件拖拽到此方框内进行上传！</h1>
	</div>
	<!-- 显示文件列表 -->
	<ul id="fileList"></ul>
  </div>
  <hr/>
  
  <script type="text/javascript">
		//获取文件的标记
		var fileMd5;
		//监控文件的三个上传时间点
		//时间点一：所有分块进行上传之前（1.计算文件的MD5 2.判断是否秒传）	
		//时间点二： 如果有分块，在每个分块发送之前调用 （选文后台该分块是否保存成功）
		//时间点三：在所有分块发送完成之后调用（通知后台合并）
		WebUploader.Uploader.register({
			"before-send-file":"beforeSendFile",
			"before-send": "beforeSend",
			"after-send-file": "afterSendFile"
		},{
			//时间点一
			beforeSendFile:function(file){
                //创建一个deffered
                var deferred = WebUploader.Deferred();
                //1.计算文件的唯一标记，用于断点续传和秒传
                (new WebUploader.Uploader()).md5File(file,0,5*1024*1024)
                    .progress(function(percentage){
                        $("#"+file.id).find("div.state").text("正在获取文件信息...");
                    })
                    .then(function(val){
                        fileMd5 = val;
                        $("#"+file.id).find("div.state").text("成功获取文件信息");
                        //获取文件信息之后需要进入到下一步
                        deferred.resolve();
                        //2.请求后台是否保存过该文件，如果存在，则跳过该文件，实现秒传功能
                    });
                //返回deffered
                return deferred.promise();
            },
		
            //时间点2：如果有分块上传，则 每个分块上传之前调用此函数
            //block:代表当前分块对象
            beforeSend:function(block){
            	//alert(fileMd5);
            	//1.请求后台是否保存过当前分块，如果存在，则跳过该分块文件，实现断点续传功能
                var deferred = WebUploader.Deferred();
                //请求后台是否保存完成该文件信息，如果保存过，则跳过，如果没有，则发送该分块内容
                $.ajax(
                    {
                    type:"POST",
                    url:"${pageContext.request.contextPath}/UploaderCheckServlet?action=checkChunk",
                    data:{
                        //文件唯一标记
                        fileMd5:fileMd5,
                        //当前分块下标
                        chunk:block.chunk,
                        //当前分块大小
                        chunkSize:block.end-block.start
                    },
                    dataType:"json",
                    success:function(response){
                        if(response.ifExist){
                            //分块存在，跳过该分块
                            deferred.reject();
                        }else{
                            //分块不存在或者不完整，重新发送该分块内容
                            deferred.resolve();
                        }
                    }
                    }
                );
            	//携带当前文件的唯一标记到后台，用于让后台创建保存该文件分块的目录
                this.owner.options.formData.fileMd5 = fileMd5;
              	//进入下一步
                return deferred.promise(); 
            },
			
			//时间点三
            afterSendFile:function(file){
                //1.如果分块上传，则通过后台合并所有分块文件
            	//请求后台合并文件
                $.ajax(
                    {
                    type:"POST",
                    url:"${pageContext.request.contextPath}/UploaderCheckServlet?action=mergeChunks",
                    data:{
                        //文件唯一标记
                        fileMd5:fileMd5,
                        //文件名称
                        fileName:file.name
                    },
                    dataType:"json",
                    success:function(response){
                        alert(response.msg);
                    }
                    }
                );
            },
		});
		
	
		/*1.初始化WebUploader，以及配置全局参数 */
		var uploader = WebUploader.create({
			// swf文件路径
			swf : "${pageContext.request.contextPath}/js/Uploader.swf",
			// 文件接收服务端。
			server : "${pageContext.request.contextPath}/UploaderServlet",
			// 选择文件的按钮,可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick : '#filePicker',
			// 自动上传
			auto : true,
			//开启拖拽功能，指定拖拽区域
			dnd:"#dndArea",
			//禁止页面其他地方拖拽功能
			disableGlobalDnd:true,
			//开启黏贴功能
			paste:"#uploader",
			//开启分片上传
			chunked:true,
			/*只允许移动excel类型的xls文件!*/
			accept:{
				title:'files',
				extensions:'xls',
				mimetypes:'excel/xls'
			}
		});
		//2. 选择文件后，文件信息队列展示
		//由于webuploader不处理UI逻辑，所以需要去监听fileQueued事件来实现
		//注册fileQueued事件：当文件加入队列后触发
		uploader.on("fileQueued",function(file){
			//追加文件信息div
			$("#fileList").append("<div id='" + file.id + "'class='fileInfo'><img/><span>" + file.name +
					"</span><div class='state'>等待上传...</div><span class='text'><span></div>");
			//生成缩略图：调用makeThumb()方法
			//error：制造缩略图失败
			//src:缩略图的路径
			uploader.makeThumb(file,function(error,src){
				var id = $("#" + file.id);
				//如果失败，则显示不能预览
				if(error){
					id.find("img").replaceWith("您所上传的文件为 : ");
				}
				//成功，则显示缩略图到指定位置
				id.find("img").attr("src",src);
			});
			
		});
		
		//3. 注册上传监听
		//percentage:当前上传进度0-1
		uploader.on("uploadProgress",function(file,percentage){
			var id=$("#"+file.id);
			//更新状态信息
			id.find("div.state").text("上传中...");
			//更新上传的百分比
			id.find("span.text").text(Math.round(percentage*100)+"% !");
			//更新状态信息
			$("#"+file.id).find("div.state").text("文件上传完毕!");
			
		});
		/*上传成功*/
		uploader.on( 'uploadSuccess', function( file ) {
		    $( '#'+file.id ).find('p.state').text('已上传');
		});
		/*上传失败*/
		uploader.on( 'uploadError', function( file ) {
		    $( '#'+file.id ).find('p.state').text('上传出错');
		});
		/*上传结束*/
		uploader.on( 'uploadComplete', function( file ) {
		    $( '#'+file.id ).find('.progress').fadeOut();
		});
	</script>

<%--   <script type="text/javascript">
		$(function(){
			$("#submitBtn").click(function(){
				$.ajax({
				   type: "POST",
				   url: "<%=request.getContextPath() %>/RegisterServlet?oprateType=userUpdate",
				   data: {
					   "userName":$("#userName").val(),
					   "fileName":$("#fileName").val(),
				   },
				   dataType: "json",                             //请求页面返回的数据类型 
				   success: function(data){
				     if(data.message=="no"){
				    	 $.messager.alert('提示信息','添加用户失败!','info');
				     }else{
				    	 $.messager.alert('提示信息','添加用户成功!','info');
				    	 $('#win').window("close"); 
				    	 $("#searchBtn").click();
				     }
				   }
				});
			});
		});
	</script> --%>
</body>
</html>