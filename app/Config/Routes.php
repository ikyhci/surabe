<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Dashboard::index');
$routes->get('/login','PublicPages::login');
$routes->get('/unauthorized','Dashboard::Unauthorized');
//Users

// user page routes ['filter' => 'appFilter','cors'],
$routes->group('/',  function($routes){
	$routes->get('dashboard', 'Dashboard::index');
	$routes->get('penilaian-mandiri', 'Pages\PagesUsersControllers::index');
	$routes->post('get-detail-form', 'Pages\PagesUsersControllers::detailForm');
	$routes->get('detail-form', 'Pages\PagesUsersControllers::listDetail');
});

//Api Users ['filter' => 'apiFilter','cors'],
$routes->group('api',  function($routes){
	// $routes->get('dashboard', 'Dashboard::index');
	$routes->get('get-penilaian-mandiri', 'Api\ApiUserControllers::getPenilaianMandiri');
	$routes->get('get-indikator-penilaian', 'Api\ApiUserControllers::getSoalData');
});


// Soal page routes , ['filter' => 'appFilter','cors'],
$routes->group('/', function($routes){
	$routes->get('dashboard', 'Dashboard::index');
	$routes->get('/tambah-data-penilaian', 'Pages\PagesSoalControllers::addData');
});

//end soal
// Soal Api Routes  ['filter' => 'apiFilter','cors'],
 $routes->group('api', function($routes){
	$routes->post('save-aspek', 'Api\ApiSoalControllers::saveAspek');
	$routes->post('save-sub-aspek', 'Api\ApiSoalControllers::saveSubAspek');
	$routes->post('save-sub-sub-aspek', 'Api\ApiSoalControllers::saveSubSubAspek');
	$routes->post('save-parameter', 'Api\ApiSoalControllers::saveParameter');
	$routes->post('save-indikator', 'Api\ApiSoalControllers::saveIndikator');
	$routes->post('save-bukti-dukung', 'Api\ApiSoalControllers::saveBuktiDukung');
	
 });

// Global API ['filter' => 'apiFilter','cors'],
$routes->group('api',  function($routes){
	$routes->get('get-penilaian-spbe', 'Api\ApiGlobalControllers::getPenilain');
	$routes->get('get-aspek', 'Api\ApiGlobalControllers::getAspek');
	$routes->get('get-sub-aspek', 'Api\ApiGlobalControllers::getSubAspek');
	$routes->get('get-sub-sub-aspek', 'Api\ApiGlobalControllers::getSubSubAspek');
	$routes->get('get-indikator', 'Api\ApiGlobalControllers::getIndikator');
	$routes->get('get-jenis-jawaban', 'Api\ApiGlobalControllers::getJenisJawaban');
	$routes->get('get-opd', 'Api\ApiGlobalControllers::getOPD');
	$routes->get('get-roles', 'Api\ApiGlobalControllers::getRoles');
});


// Super Admin Routes ['filter' => 'appFilter','cors'],
$routes->group('/', function($routes){
	$routes->get('user-management', 'Pages\PagesSuperAdminControllers::manageUsers');
	$routes->get('user-management/(:segment)', 'Pages\PagesSuperAdminControllers::manageUsersDetail/$1');

});

// Super Admin API Routes ['filter' => 'apiFilter','cors'],
$routes->group('api', function($routes){
	$routes->get('get-users', 'Api\ApiSuperAdminControllers::getUsers');
	$routes->get('get-user/(:segment)', 'Api\ApiSuperAdminControllers::getUser/$1');
	$routes->POST('put-user/(:any)', 'Api\ApiSuperAdminControllers::updateUser/$1');
	$routes->POST('post-user', 'Api\ApiSuperAdminControllers::addUser');
	$routes->delete('delete-user/(:any)', 'Api\ApiSuperAdminControllers::deleteUser/$1');
});

