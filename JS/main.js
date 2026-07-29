/**
 * TN HAPPY KIDS SCHOOL - AFTER SCHOOL ADMISSION FORM
 * Client-Side Interactive Form, Photo Previews & Stepper Wizard Logic
 */

document.addEventListener('DOMContentLoaded', function () {

    // 1. Auto-Calculate Age from DOB
    const dobInput = document.getElementById('txtDOB');
    const ageInput = document.getElementById('txtAge');

    if (dobInput && ageInput) {
        dobInput.addEventListener('change', function () {
            calculateAge();
            updateStepperState();
        });
    }

    function calculateAge() {
        if (!dobInput || !ageInput) return;
        const dob = new Date(dobInput.value);
        if (!isNaN(dob.getTime())) {
            const today = new Date();
            let age = today.getFullYear() - dob.getFullYear();
            const m = today.getMonth() - dob.getMonth();
            if (m < 0 || (m === 0 && today.getDate() < dob.getDate())) {
                age--;
            }
            ageInput.value = age > 0 ? age + ' Years' : 'Under 1 Year';
        }
    }

    // 2. Interactive Stepper Wizard Navigation & State Tracker
    const formInputs = document.querySelectorAll('.form-control-custom, select.form-select');
    formInputs.forEach(input => {
        input.addEventListener('input', updateStepperState);
        input.addEventListener('change', updateStepperState);
    });

    function updateStepperState() {
        const requiredInputsStep1 = document.querySelectorAll('#step1 [required]');
        let step1Filled = 0;
        requiredInputsStep1.forEach(input => {
            if (input.value && input.value.trim() !== '') {
                step1Filled++;
            }
        });

        const step1Completed = requiredInputsStep1.length > 0 && step1Filled === requiredInputsStep1.length;

        const stepInd1 = document.getElementById('stepIndicator1');
        const stepInd2 = document.getElementById('stepIndicator2');
        const connector = document.getElementById('stepConnector');

        if (step1Completed) {
            if (stepInd1) {
                stepInd1.classList.remove('active');
                stepInd1.classList.add('completed');
            }
            if (stepInd2) {
                stepInd2.classList.add('active');
            }
            if (connector) {
                connector.classList.add('active');
            }
        } else {
            if (stepInd1) {
                stepInd1.classList.add('active');
                stepInd1.classList.remove('completed');
            }
            if (stepInd2) {
                stepInd2.classList.remove('active');
            }
            if (connector) {
                connector.classList.remove('active');
            }
        }
    }

    // 3. Photo Live Previews for Student, Parents & Guardians
    setupPhotoPreview('filePhoto', 'imgPhotoPreview');
    setupPhotoPreview('fileFatherPhoto', 'imgFatherPhotoPreview');
    setupPhotoPreview('fileMotherPhoto', 'imgMotherPhotoPreview');
    setupPhotoPreview('fileGuardian1Photo', 'imgGuardian1PhotoPreview');
    setupPhotoPreview('fileGuardian2Photo', 'imgGuardian2PhotoPreview');

    function setupPhotoPreview(fileInputId, imgPreviewId) {
        const fileInput = document.getElementById(fileInputId);
        const imgPreview = document.getElementById(imgPreviewId);

        if (fileInput && imgPreview) {
            fileInput.addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (evt) {
                        imgPreview.src = evt.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
    }

    // Initial calculation on load
    calculateAge();
    updateStepperState();
});

function printReport() {
    window.print();
}
