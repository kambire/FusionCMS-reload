	<div class="container">
		<script type="text/javascript">
			$(document).ready(function()
			{
				function checkIfLoaded()
				{
					if(typeof Store !== "undefined")
					{
						<div class="container">
							<script type="text/javascript">
								$(document).ready(function()
								{
									function checkIfLoaded()
									{
										if(typeof Store !== "undefined")
										{
											Store.Customer.initialize({$vp}, {$dp});
										}
										else
										{
											setTimeout(checkIfLoaded, 50);
										}
									}

									checkIfLoaded();
								});
							</script>

							<div id="checkout" style="display:none"></div>

							<div id="store">
								<div class="store-balance mb-3">
									<div class="store-balance-label">Tus monedas</div>
									<div class="store-balance-values">
										<span class="store-balance-item">
											<img src="{$url}application/images/icons/lightning.png" align="absmiddle" />
											<span id="store_info_vp">{$vp}</span> {lang("vp", "store")}
										</span>
										<span class="store-balance-item">
											<img src="{$url}application/images/icons/coins.png" align="absmiddle" />
											<span id="store_info_dp">{$dp}</span> {lang("dp", "store")}
										</span>
									</div>
								</div>

								<div class="row g-3 align-items-end mb-3">
									<div class="col-12 col-md-3">
										<label class="form-label" for="sort_by">{lang("sort_by", "store")}</label>
										<select class="form-select" id="sort_by" name="sort_by" onChange="Store.Filter.sort(this.value)">
											<option value="standard" selected>{lang("default", "store")}</option>
											<option value="name">{lang("name", "store")}</option>
											<option value="priceVp">{lang("price", "store")} ({lang("vp", "store")})</option>
											<option value="priceDp">{lang("price", "store")} ({lang("dp", "store")})</option>
											<option value="quality">{lang("item_quality", "store")}</option>
										</select>
									</div>

									<div class="col-12 col-md-3">
										<label class="form-label" for="item_quality">{lang("item_quality", "store")}</label>
										<select class="form-select" id="item_quality" name="item_quality" onChange="Store.Filter.setQuality(this.value)">
											<option value="ALL" selected>{lang("all_items", "store")}</option>
											<option value="0" class="q0">{lang("poor", "store")}</option>
											<option value="1" class="q1">{lang("common", "store")}</option>
											<option value="2" class="q2">{lang("uncommon", "store")}</option>
											<option value="3" class="q3">{lang("rare", "store")}</option>
											<option value="4" class="q4">{lang("epic", "store")}</option>
											<option value="5" class="q5">{lang("legendary", "store")}</option>
											<option value="6" class="q6">{lang("artifact", "store")}</option>
											<option value="7" class="q7">{lang("heirloom", "store")}</option>
										</select>
									</div>

									<div class="col-12 col-md-4">
										<label class="form-label" for="filter_name">{lang("filter", "store")}</label>
										<input class="form-control" type="text" id="filter_name" placeholder="{lang('filter', 'store')}" onKeyUp="Store.Filter.setName(this.value)" />
									</div>

									<div class="col-12 col-md-2 d-flex gap-2">
										<a href="javascript:void(0)" onClick="Store.Filter.toggleVote(this)" class="nice_button nice_active flex-fill text-center">
											<img src="{$url}application/images/icons/lightning.png" align="absmiddle" /> {lang("vp", "store")}
										</a>
										<a href="javascript:void(0)" onClick="Store.Filter.toggleDonate(this)" class="nice_button nice_active flex-fill text-center">
											<img src="{$url}application/images/icons/coins.png" align="absmiddle" /> {lang("dp", "store")}
										</a>
									</div>
								</div>

								<div class="row g-3">
									<div class="col-12 col-xl-9" id="store_realms">
										{foreach from=$data item=realm key=realmId}
											<div class="mb-4">
												<h3 class="mb-3">{$realm.name}</h3>

												{if isset($realm.items.groups)}
													{foreach from=$realm.items.groups item=group}
														{if isset($group.items) && count($group.items) > 0}
															<div class="store-category mb-4" id="store_group_{$realmId}_{$group.id}">
																<h4 class="store-category-title mb-3">{$group.title}</h4>
																<div class="item_group store-grid row g-3">
																	{foreach from=$group.items item=item}
																		<div class="store_item col-12 col-sm-6 col-md-3" id="item_{$item.id}">
																			<div class="store-item-card card h-100">
																				<div class="store-item-icon">
																					<img class="item_icon store-item-icon-img" src="{$CI->config->item('api_item_icons')}/large/{$item.icon}.jpg" align="absmiddle" {if $item.tooltip}data-realm="{$item.realm}" rel="item={$item.itemid}"{/if}>
																					{if $item.itemcount > 1 && !preg_match("/,/", $item.itemcount)}<span class="wh-icon-text" data-type="number">{$item.itemcount}</span>{/if}
																				</div>
																				<div class="card-body">
																					<a {if $item.tooltip}href="{$url}item/{$item.realm}/{$item.itemid}" data-realm="{$item.realm}" rel="item={$item.itemid}"{/if} class="item_name q{$item.quality}">
																						{character_limiter($item.name, 20)}
																					</a>
																					<p class="store-item-desc mb-0">{character_limiter($item.description, 25)}</p>
																			</div>
																			<div class="card-footer">
																				<div class="store_buttons d-grid gap-2">
																					{if $item.vp_price}
																						<a href="javascript:void(0)" onClick="Store.Cart.add({$item.id}, '{$item.itemid}', '{addslashes(preg_replace('/\"/', "'", $item.name))}', {$item.vp_price}, 'vp', '{addslashes($realm.name)}', {$realmId}, {$item.quality}, {$item.tooltip})" class="nice_button vp_button">
																						<img src="{$url}application/images/icons/lightning.png" align="absmiddle"> <span class="vp_price_value">{$item.vp_price}</span> {lang("vp", "store")}
																					</a>
																					{/if}
																					{if $item.dp_price}
																						<a href="javascript:void(0)" onClick="Store.Cart.add({$item.id}, '{$item.itemid}', '{addslashes(preg_replace('/\"/', "'", $item.name))}', {$item.dp_price}, 'dp', '{addslashes($realm.name)}', {$realmId}, {$item.quality}, {$item.tooltip})" class="nice_button dp_button">
																							<img src="{$url}application/images/icons/coins.png" align="absmiddle"> <span class="dp_price_value">{$item.dp_price}</span> {lang("dp", "store")}
																						</a>
																					{/if}
																				</div>
																			</div>
																		</div>
																	</div>
																{/foreach}
																</div>
															</div>
														{/if}
													{/foreach}
												{/if}

												{if isset($realm.items.items) && count($realm.items.items) > 0}
													<div class="store-category mb-4" id="store_group_{$realmId}_ungrouped">
														<h4 class="store-category-title mb-3">Other Items</h4>
														<div class="item_group store-grid row g-3">
															{foreach from=$realm.items.items item=item}
																<div class="store_item col-12 col-sm-6 col-md-3" id="item_{$item.id}">
																	<div class="store-item-card card h-100">
																		<div class="store-item-icon">
																			<img class="item_icon store-item-icon-img" src="{$CI->config->item('api_item_icons')}/large/{$item.icon}.jpg" align="absmiddle" {if $item.tooltip}data-realm="{$item.realm}" rel="item={$item.itemid}"{/if}>
																			{if $item.itemcount > 1 && !preg_match("/,/", $item.itemcount)}<span class="wh-icon-text" data-type="number">{$item.itemcount}</span>{/if}
																	</div>
																	<div class="card-body">
																		<a {if $item.tooltip}href="{$url}item/{$item.realm}/{$item.itemid}" data-realm="{$item.realm}" rel="item={$item.itemid}"{/if} class="item_name q{$item.quality}">
																		{character_limiter($item.name, 20)}
																	</a>
																	<p class="store-item-desc mb-0">{character_limiter($item.description, 25)}</p>
																</div>
																<div class="card-footer">
																	<div class="store_buttons d-grid gap-2">
																		{if $item.vp_price}
																			<a href="javascript:void(0)" onClick="Store.Cart.add({$item.id}, '{$item.itemid}', '{addslashes(preg_replace('/\"/', "'", $item.name))}', {$item.vp_price}, 'vp', '{addslashes($realm.name)}', {$realmId}, {$item.quality}, {$item.tooltip})" class="nice_button vp_button">
																			<img src="{$url}application/images/icons/lightning.png" align="absmiddle"> <span class="vp_price_value">{$item.vp_price}</span> {lang("vp", "store")}
																		</a>
																	{/if}
																	{if $item.dp_price}
																		<a href="javascript:void(0)" onClick="Store.Cart.add({$item.id}, '{$item.itemid}', '{addslashes(preg_replace('/\"/', "'", $item.name))}', {$item.dp_price}, 'dp', '{addslashes($realm.name)}', {$realmId}, {$item.quality}, {$item.tooltip})" class="nice_button dp_button">
																			<img src="{$url}application/images/icons/coins.png" align="absmiddle"> <span class="dp_price_value">{$item.dp_price}</span> {lang("dp", "store")}
																		</a>
																	{/if}
																</div>
															</div>
														</div>
													</div>
												{/foreach}
											</div>
										</div>
									{/if}
								</div>
							{/foreach}
									</div>

									<div class="col-12 col-xl-3">
										<div class="card">
											<div id="cart">
												<div class="card-header"><span class="fa-duotone fa-shopping-cart"></span> {lang("cart", "store")} (<span id="cart_item_count">0</span> {lang("items", "store")})</div>
												<div class="card-body">
													<div id="empty_cart">{lang("empty_cart", "store")}</div>
													<div id="cart_items"></div>
												</div>
												<div class="card-footer">
													<div id="cart_price" class="d-flex">
														<div id="vp_price_full" class="p-2">
															<img src="{$url}application/images/icons/lightning.png"> <span id="vp_price">0</span> {lang("vp", "store")}
														</div>
														<div id="dp_price_full" class="p-2">
															<img src="{$url}application/images/icons/coins.png"> <span id="dp_price">0</span> {lang("dp", "store")}
														</div>
														<div class="ms-auto p-1">
															<a href="javascript:void(0)" onClick="Store.Cart.checkout(this)" class="nice_button">{lang("checkout", "store")}</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>