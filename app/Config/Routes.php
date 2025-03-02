<?php

use App\Controllers\Pages\PagesSuperAdminControllers;
use CodeIgniter\Router\RouteCollection;


/**
 * @var RouteCollection $routes
 */

$routes->setAutoRoute(false);


$routes->get('/', 'PublicPages::login');
$routes->get('/unauthorized', 'PublicPages::Unauthorized');

//login api
$routes->group('api',  function ($routes) {
	$routes->post('login', 'Auth\AuthControllers::auth');
});

//global page 
$routes->group('dashboard', ['filter' => ['appFilter', 'roles:User,Soal,Super Admin,Penilai']], function ($routes) {
	$routes->get('help', 'Dashboard::help');
	$routes->get('', 'Dashboard::index');
});
//Users


// user page routes 
$routes->group('dashboard', ['filter' => ['roles:User', 'cors']],  function ($routes) {
	$routes->get('penilaian-mandiri', 'Pages\PagesUsersControllers::index');
	$routes->post('get-detail-form', 'Pages\PagesUsersControllers::detailForm');
	$routes->get('detail-form', 'Pages\PagesUsersControllers::listDetail');
});

//Api Users 
$routes->group('api', ['filter' => ['apiFilter:User', 'cors']], function ($routes) {
	$routes->get('get-penilaian-mandiri', 'Api\ApiUserControllers::getPenilaianMandiri');
	$routes->get('get-dashboard-user','Api\ApiUserControllers::getDashboard');
	$routes->get('get-dashboard-table', 'Api\ApiUserControllers::getDataPenilaianMandiri');

	$routes->get('get-indikator-penilaian', 'Api\ApiUserControllers::getSoalData');
	$routes->post('get-detail-indikator', 'Api\ApiUserControllers::getDetailIndikator');
	$routes->post('save-jawaban', 'Api\ApiUserControllers::saveJawaban');
});


// Soal page routes , ,
$routes->group('dashboard', ['filter' => ['roles:Soal,Super Admin', 'cors']], function ($routes) {
	$routes->get('tambah-data-penilaian', 'Pages\PagesSoalControllers::addData');
});

//end soal
// Soal Api Routes 
$routes->group('api', ['filter' => ['apiFilter:Soal,Super Admin', 'cors']], function ($routes) {
	$routes->post('save-aspek', 'Api\ApiSoalControllers::saveAspek');
	$routes->post('save-sub-aspek', 'Api\ApiSoalControllers::saveSubAspek');
	$routes->post('save-sub-sub-aspek', 'Api\ApiSoalControllers::saveSubSubAspek');
	$routes->post('save-parameter', 'Api\ApiSoalControllers::saveParameter');
	$routes->post('save-indikator', 'Api\ApiSoalControllers::saveIndikator');
	$routes->post('save-bukti-dukung', 'Api\ApiSoalControllers::saveBuktiDukung');
	$routes->post('save-rb', 'Api\ApiSoalControllers::saveRb');
	$routes->post('save-form', 'Api\ApiSoalControllers::saveForm');

	$routes->post('del-parameter', 'Api\ApiSoalControllers::delParameter');
	$routes->post('del-aspek', 'Api\ApiSoalControllers::delAspek');
	$routes->post('del-sub-aspek', 'Api\ApiSoalControllers::delSubAspek');
	$routes->post('del-sub-sub-aspek', 'Api\ApiSoalControllers::delSubSubAspek');
	$routes->post('del-indikator', 'Api\ApiSoalControllers::delIndikator');
	$routes->post('del-bukti-dukung', 'Api\ApiSoalControllers::delBuktiDukung');
	$routes->post('del-rb', 'Api\ApiSoalControllers::delRb');
	$routes->post('del-form', 'Api\ApiSoalControllers::delForm');

	$routes->get('get-dashboard-data', 'Api\ApiSoalControllers::getDashboard');
});

// Global API 
$routes->group('api', ['filter' => ['apiFilter:Soal,Super Admin,Penilai,User', 'cors']],  function ($routes) {
	$routes->get('get-penilaian-spbe', 'Api\ApiGlobalControllers::getPenilain');
	$routes->get('get-aspek', 'Api\ApiGlobalControllers::getAspek');
	$routes->get('get-sub-aspek', 'Api\ApiGlobalControllers::getSubAspek');
	$routes->get('get-sub-sub-aspek', 'Api\ApiGlobalControllers::getSubSubAspek');
	$routes->get('get-indikator', 'Api\ApiGlobalControllers::getIndikator');
	$routes->get('get-jenis-jawaban', 'Api\ApiGlobalControllers::getJenisJawaban');
	$routes->get('get-opd', 'Api\ApiGlobalControllers::getOPD');
	$routes->get('get-roles', 'Api\ApiGlobalControllers::getRoles');
	$routes->get('get-bukti-dukung', 'Api\ApiGlobalControllers::getBuktiDukung');
	$routes->get('get-rb', 'Api\ApiGlobalControllers::getRb');
	$routes->get('get-form', 'Api\ApiGlobalControllers::getForms');
	$routes->get('nilai-opd', 'Api\ApiGlobalControllers::nilai');

	$routes->post('get-user-by-id', 'Api\ApiGlobalControllers::getUSerById');

	$routes->post('update-user-data', 'Api\ApiGlobalControllers::updateUserData');

	$routes->get('capaian-opd', 'Api\ApiSuperAdminControllers::capaianOpd');
	// Logout
	$routes->post('logout', 'Auth\AuthControllers::Logout');
});


// Super Admin Routes 
$routes->group('dashboard', ['filter' => ['roles:Super Admin', 'cors']], function ($routes) {
	$routes->get('user-management', 'Pages\PagesSuperAdminControllers::manageUsers');
	$routes->get('user-management/(:segment)', 'Pages\PagesSuperAdminControllers::manageUsersDetail/$1');
	$routes->get('opd-management', [PagesSuperAdminControllers::class, 'manageOpd']);
});

// Super Admin API Routes 
$routes->group('api', ['filter' => ['apiFilter:Super Admin', 'cors']], function ($routes) {
	$routes->get('get-users', 'Api\ApiSuperAdminControllers::getUsers');
	$routes->get('get-user/(:segment)', 'Api\ApiSuperAdminControllers::getUser/$1');
	$routes->POST('put-user/(:any)', 'Api\ApiSuperAdminControllers::updateUser/$1');
	$routes->POST('post-user', 'Api\ApiSuperAdminControllers::addUser');
	$routes->delete('delete-user/(:any)', 'Api\ApiSuperAdminControllers::deleteUser/$1');
	$routes->post('save-opd', 'Api\ApiSuperAdminControllers::saveOPD');
	$routes->post('del-opd', 'Api\ApiSuperAdminControllers::delOPD');


});

// route Penilai
$routes->group('dashboard', ['filter' => ['roles:Penilai,Super Admin', 'cors']], function ($routes) {
	$routes->get('penilaian', 'Pages\PagesPenilaiControllers::index');
	$routes->get('penilaian/detail-form', 'Pages\PagesPenilaiControllers::detailForm');
});

$routes->group('api', ['filter' => ['apiFilter:Penilai,Super Admin', 'cors']], function ($routes) {
	$routes->get('penilaian/data-opd', 'Api\ApiPenilaiControllers::getPenilaianMandiri');
	$routes->post('penilaian/jawabanOpdIndikator', 'Api\ApiPenilaiControllers::jawabanOpdIndikator');
	$routes->post('penilaian/simpanPoint', 'Api\ApiPenilaiControllers::simpanPoint');
	$routes->post('penilaian/uploadBuktiDukung', 'Api\ApiPenilaiControllers::uploadBuktiDukung');

});
