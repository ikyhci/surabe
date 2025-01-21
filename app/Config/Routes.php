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
	$routes->get('get-detail-form', 'Pages\PagesUsersControllers::detailForm');
	$routes->get('detail-form', 'Pages\PagesUsersControllers::listDetail');
});

//Api Users ['filter' => 'appFilter','cors'],
$routes->group('api',  function($routes){
	// $routes->get('dashboard', 'Dashboard::index');
	$routes->get('get-penilaian-mandiri', 'Api\ApiUserControllers::getPenilaianMandiri');
	$routes->get('get-indikator-penilaian', 'Api\ApiUserControllers::getSoalData');
});


// Soal page routes
// $routes->group('/', ['filter' => 'appFilter','cors'], function($routes){
	$routes->get('dashboard', 'Dashboard::index');
	$routes->get('/tambah-data-penilaian', 'Pages\PagesSoalControllers::addData');
// });

//end soal
// Soal Api Routes  ['filter' => 'appFilter','cors'],
 $routes->group('api', function($routes){
	$routes->post('save-aspek', 'Api\ApiSoalControllers::saveAspek');
	// $routes->post('save-sub-aspek', 'Api\ApiSoalControllers::saveAspek');
	// $routes->post('save-sub-sub-aspek', 'Api\ApiSoalControllers::saveAspek');
	$routes->post('save-parameter', 'Api\ApiSoalControllers::saveParameter');
	$routes->post('save-indikator', 'Api\ApiSoalControllers::saveIndikator');
 });

// Global API ['filter' => 'appFilter','cors'],
$routes->group('api',  function($routes){
	$routes->get('get-penilaian-spbe', 'Api\ApiGlobalControllers::getPenilain');
	$routes->get('get-aspek', 'Api\ApiGlobalControllers::getAspek');
	$routes->get('get-sub-aspek', 'Api\ApiGlobalControllers::getSubAspek');
	$routes->get('get-sub-sub-aspek', 'Api\ApiGlobalControllers::getSubSubAspek');
	$routes->get('get-indikator', 'Api\ApiGlobalControllers::getIndikator');
});




