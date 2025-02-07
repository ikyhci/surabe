<div class="modal fade text-left" id="edit-data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel160" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title white" id="title-edit">
                   Edit Data
                </h5>
                
            </div>
            <div class="modal-body">
               <div id="content-edit">
                
                   <form id="formdata" class="needs-validation" novalidate>
                    <input type="hidden" id="idx" name="idx">

                        <div class="form-group">
                            <h6>Nama Lengkap <span class="text-danger">*</span></h6>
                            <input type="text" class="form-control" id="fname" name="fname" placeholder="Nama Lengkap" required>
                        </div>
                        <div class="form-group">
                            <h6>Nama Pengguna <span class="text-danger">*</span></h6>
                            <input type="text" class="form-control" id="uname" name="uname" placeholder="Nama Pengguna" required>
                        </div>
                        <div class="form-group">
                            <h6>Email <span class="text-danger">*</span></h6>
                            <input type="text" class="form-control" id="mail" name="mail" placeholder="Email" required>
                        </div>
                        <div class="form-group">
                            <h6>No Hp<span class="text-danger">*</span></h6>
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="No Hp" required>
                        </div>
                   </form>

               </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">
                    <i class="bx bx-x d-block d-sm-none"></i>
                    <span class="d-none d-sm-block">Close</span>
                </button>
                <button type="button" class="btn btn-primary ml-1" id="updates">
                    <i class="bx bx-check d-block d-sm-none"></i>
                    <span class="d-none d-sm-block">Save</span>
                </button>
                
            </div>
        </div>
    </div>
</div>