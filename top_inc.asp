<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
	<TITLE>(주)인프라정보기술</TITLE>
	<meta charset="utf-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<link rel="stylesheet" type="text/css" href="/css/default.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css" />

	<script src="http://code.jquery.com/jquery-latest.js"></script>

	<script type="text/javascript">
		$(document).ready(function () {
			$('#close').click(function () {
				$('#pop').hide();
			});
		});
	</script>

	<script type="text/javascript">
		WebFontConfig = {
			google: { families: ['Open+Sans::latin'] }
		};
		(function () {
			var wf = document.createElement('script');
			wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
				'://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
			wf.type = 'text/javascript';
			wf.async = 'true';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(wf, s);
		})(); </script>



	<!-- 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 -->
	<script type="text/javascript" src="//wsa.mig-log.com/wsalog.js"> </script>
	<script type="text/javascript">
		wsa.inflow("www.infrait.co.kr");
		wsa_do(wsa);
	</script>



	<style type="text/css">
		#pop {
			width: 460px;
			height: 500px;
			background: #fff;
			color: #ccc;
			position: absolute;
			top: 70px;
			left: 100px;
			text-align: center;
			border: 1px solid #ccc;
		}
	</style>

</HEAD>



<BODY>
	<div>

		<div class="header_wrap">
			<div class="top_wrap">
				<div class="logo"><a href="/index.asp"><img src="/images/logo.png"></a></div>
				<div class="menu_wrap">
					<ul class="menu">
						<li class="main_mn"><a href="/company/company.asp">회사소개</a></li>
						<li class="main_mn"><a href="/products/products_01.asp">제품소개</a>
							<ul>
								<li class="dep_01"><a href="/products/products_01_01.asp">HEXAGON PPM 제품군</a></li>
								<li class="dep_02"><span><a href="/products/products_01_01.asp">CADWorx</a></span></li>
								<li class="dep_02"><span><a href="/products/products_01_02.asp">CAESAR II</a></span>
								</li>
								<li class="dep_03" style="height:25px;"><span><a
											href="/products/products_01_05.asp">FEATools</a></span></li>
								<li class="dep_02"><span><a href="/products/products_01_03.asp">PV Elite</a></span></li>
								<li class="dep_02"><span><a href="/products/products_01_04.asp">TANK</a></span></li>
								<li class="dep_02"><span><a href="/products/products_01_06.asp">NozzlePRO</a></span>
								</li>
								<!--
								<li class="dep_01"><a href="/products/products_bricscad.asp">CADPOWER PREMIUM</a></li>
								<li class="dep_02"><span><a href="/products/products_cpfz.asp">CADPOWER PREMIUM for
											ZWCAD</a></span></li>
								-->
								<li class="dep_01"><a href="/products/products_03.asp">Trimble 제품군</a></li>
								<li class="dep_01"><a href="/products/products_04.asp">ACT-3D 제품군</a></li>
							</ul>
						</li>
						<li class="main_mn"><a href="/services/services_02.asp">솔루션</a>
							<ul>
								<!--							<li class="dep_01"><a href="/services/services_01.asp">Fluid Simulation 서비스 및 컨설팅</a></li>-->
								<li class="dep_01"><a href="/services/services_02.asp">Lumion 시각화</a></li>
							</ul>
						</li>
						<li class="main_mn"><a href="/customer/customer_mailForm.asp">고객지원</a>
							<ul>
								<li class="dep_01"><a href="/customer/customer_mailForm.asp">온라인 상담</a></li>
								<li class="dep_01"><a href="/bbs/qna.asp">Q & A</a></li>
								<li class="dep_01"><a href="/bbs/data.asp">자료실</a></li>
								<li class="dep_01"><a href="/customer/customer_training.asp">교육일정 안내</a></li>
							</ul>
						</li>
						<li class="main_mn"><a href="/bbs/notice.asp">회사소식</a></li>
						<li class="main_mn"><a href="http://softmoa.co.kr/shop/main/index.php">쇼핑몰</a></li>
					</ul>
				</div>
			</div>
		</div>
