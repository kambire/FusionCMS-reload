{strip}

{assign var=user_display_name value=(($CI->user->isOnline()) ? $CI->user->getNickname() : lang('guest', 'sidebox_visitors'))}
{assign var=user_avatar_alt value=sprintf(lang('global_user_avatar', 'theme'), $user_display_name)}
{assign var=user_avatar_src value=(($CI->user->isOnline()) ? $CI->user->getAvatar() : ($url|cat:basename($APPPATH)|cat:'/images/avatars/default.gif'))}

{/strip}

<!-- Mobile menu.Start -->
<div id="mobileMenu" class="offcanvas offcanvas-end" aria-labelledby="mobileMenuLabel">
	<div class="offcanvas-header">
		<h5 id="mobileMenuLabel" class="offcanvas-title">{lang('nav', 'theme')}</h5>
		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>

	<div class="offcanvas-body">
		<div class="userbar">
			<div class="userbar-avatar">
				<a href="{$url}ucp/avatar" title="{$user_avatar_alt}">
					<img width="25" height="25" alt="{$user_avatar_alt}" src="{$user_avatar_src}" />
				</a>
			</div>

			<div class="userbar-info">
				<div class="info-username">{$user_display_name}</div>
				<div class="info-dropdown">
					<div class="dropdown">
						<a class="dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa-duotone fa-bars"></i></a>
						<ul class="dropdown-menu">
							{if $CI->user->isOnline()}
								<li><a href="{$url}ucp" class="dropdown-item" title="{lang('account', 'main')}">{lang('account', 'main')}</a></li>
								<li><a href="{$url}logout" class="dropdown-item" title="{lang('logout', 'main')}">{lang('logout', 'main')}</a></li>
							{else}
								<li><a href="{$url}login" class="dropdown-item" title="{lang('login', 'main')}">{lang('login', 'main')}</a></li>
								<li><a href="{$url}register" class="dropdown-item" title="{lang('register', 'main')}">{lang('register', 'main')}</a></li>
							{/if}
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- Navbar.Start -->
		<nav class="navbar">
			<!-- Nav.Start -->
			<ul class="navbar-nav">
				{$menus.top}
				{if $CI->user->isOnline() && $CI->user->isStaff() && hasPermission('view', 'admin')}
					<li class="nav-item">
						<a href="{$url}admin" class="nav-link" title="Admin">Admin</a>
					</li>
				{/if}
				{if $CI->user->isOnline() && hasPermission('view', 'store') && $CI->config->item('ucp_store')}
					<li class="nav-item">
						<a href="{$url}{$CI->config->item('ucp_store')}" class="nav-link" title="{lang('item_store', 'store')}">{lang('item_store', 'store')}</a>
					</li>
				{/if}
			</ul>
			<!-- Nav.End -->
		</nav>
		<!-- Navbar.End -->
	</div>
</div>
<!-- Mobile menu.End -->

<!-- Header.Start -->
<header class="header" header>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<!-- Navbar.Start -->
				<nav class="navbar navbar-expand-xl">
					<h1 hidden>{$serverName}</h1>

					<!-- Brand.Start -->
					<a href="{$url}" class="navbar-brand" title="{sprintf(lang('logo', 'theme'), $serverName)}"></a>
					<!-- Brand.End -->

					<!-- Toggler.Start -->
					<button type="button" class="navbar-toggler" data-bs-toggle="offcanvas" data-bs-target="#mobileMenu" aria-controls="mobileMenu">
						<span class="navbar-toggler-icon"></span>
					</button>
					<!-- Toggler.End -->

					<!-- Collapse.Start -->
					<div class="navbar-collapse collapse">
						<!-- Nav.Start -->
						<ul class="navbar-nav ms-auto">
							{$menus.top}
							{if $CI->user->isOnline() && $CI->user->isStaff() && hasPermission('view', 'admin')}
								<li class="nav-item">
									<a href="{$url}admin" class="nav-link" title="Admin">Admin</a>
								</li>
							{/if}
							{if $CI->user->isOnline() && hasPermission('view', 'store') && $CI->config->item('ucp_store')}
								<li class="nav-item">
									<a href="{$url}{$CI->config->item('ucp_store')}" class="nav-link" title="{lang('item_store', 'store')}">{lang('item_store', 'store')}</a>
								</li>
							{/if}

							<li class="nav-item dropdown">
								<a href="#" class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="{$user_avatar_alt}">
									<img width="25" height="25" alt="{$user_avatar_alt}" src="{$user_avatar_src}" />
								</a>
								<ul class="dropdown-menu dropdown-menu-end">
									{if $CI->user->isOnline()}
										<li><a href="{$url}ucp" class="dropdown-item" title="{lang('account', 'main')}">{lang('account', 'main')}</a></li>
										<li><a href="{$url}logout" class="dropdown-item" title="{lang('logout', 'main')}">{lang('logout', 'main')}</a></li>
									{else}
										<li><a href="{$url}login" class="dropdown-item" title="{lang('login', 'main')}">{lang('login', 'main')}</a></li>
										<li><a href="{$url}register" class="dropdown-item" title="{lang('register', 'main')}">{lang('register', 'main')}</a></li>
									{/if}
								</ul>
							</li>
						</ul>
						<!-- Nav.End -->
					</div>
					<!-- Collapse.End -->
				</nav>
				<!-- Navbar.End -->
			</div>
		</div>
	</div>
</header>
<!-- Header.End -->