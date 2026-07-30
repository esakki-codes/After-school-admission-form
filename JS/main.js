/**
 * TN HAPPY KIDS SCHOOL - AFTER SCHOOL ADMISSION FORM
 * Client-Side Interactive Form, Photo Previews & Stepper Wizard Logic
 */

const DEFAULT_AVATAR = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>";

// Global Window Function Bindings for HTML Inline Attributes
window.previewPhoto = function (input, imgPreviewId) {
    if (input && input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function (e) {
            const img = document.getElementById(imgPreviewId);
            if (img) {
                img.src = e.target.result;
                img.style.display = 'block';
            }
            // Save to sessionStorage for RFID Cards
            if (imgPreviewId.includes('Father')) sessionStorage.setItem('rfidPhotoFather', e.target.result);
            if (imgPreviewId.includes('Mother')) sessionStorage.setItem('rfidPhotoMother', e.target.result);
            if (imgPreviewId.includes('Guardian1')) sessionStorage.setItem('rfidPhotoG1', e.target.result);
            if (imgPreviewId.includes('Guardian2')) sessionStorage.setItem('rfidPhotoG2', e.target.result);
            if (imgPreviewId.includes('PhotoPreview') && !imgPreviewId.includes('Father') && !imgPreviewId.includes('Mother')) {
                sessionStorage.setItem('rfidPhotoStudent', e.target.result);
            }
        };
        reader.readAsDataURL(input.files[0]);
    }
};

function getDobEl() {
    return document.getElementById('txtDOB') || 
           document.querySelector('input[name="txtDOB"]') || 
           document.querySelector('input[type="date"]') ||
           document.querySelector('input[name*="DOB"]') ||
           document.querySelector('input[id*="DOB"]');
}

function getAgeEl() {
    return document.getElementById('txtAge') || 
           document.querySelector('input[name="txtAge"]') || 
           document.querySelector('input[name*="Age"]') ||
           document.querySelector('input[id*="Age"]');
}

window.calculateAge = function () {
    const dobInput = getDobEl();
    const ageInput = getAgeEl();
    if (!dobInput || !ageInput) return;

    const val = (dobInput.value || '').trim();
    if (!val) {
        ageInput.value = '';
        return;
    }

    // Match all number sequences in the input string
    const nums = val.match(/\d+/g);
    if (!nums || nums.length < 3) return;

    let y, m, d;
    const n0 = parseInt(nums[0], 10);
    const n1 = parseInt(nums[1], 10);
    const n2 = parseInt(nums[2], 10);

    if (n0 > 1000) {
        // YYYY-MM-DD or YYYY/MM/DD
        y = n0; m = n1; d = n2;
    } else if (n2 > 1000) {
        // DD/MM/YYYY or MM/DD/YYYY
        y = n2;
        if (n0 > 12) {
            d = n0; m = n1;
        } else if (n1 > 12) {
            d = n1; m = n0;
        } else {
            d = n0; m = n1;
        }
    } else {
        return;
    }

    if (isNaN(y) || isNaN(m) || isNaN(d) || y < 1900) return;

    const today = new Date();
    let years = today.getFullYear() - y;
    let months = (today.getMonth() + 1) - m;
    let days = today.getDate() - d;

    if (days < 0) {
        months--;
    }
    if (months < 0) {
        years--;
        months += 12;
    }

    let resultText = '';
    if (years < 0) {
        resultText = 'Invalid Date';
    } else if (years === 0) {
        resultText = months > 0 ? months + (months === 1 ? ' Month' : ' Months') : 'Under 1 Month';
    } else if (months > 0) {
        resultText = years + (years === 1 ? ' Year ' : ' Years ') + months + (months === 1 ? ' Month' : ' Months');
    } else {
        resultText = years + (years === 1 ? ' Year' : ' Years');
    }

    if (ageInput.value !== resultText) {
        ageInput.value = resultText;
        ageInput.setAttribute('value', resultText);
    }
};

document.addEventListener('DOMContentLoaded', function () {

    // 1. Precise Auto-Calculate Age from DOB
    const dobInput = document.getElementById('txtDOB');
    if (dobInput) {
        ['input', 'change', 'blur', 'keyup', 'click'].forEach(evtType => {
            dobInput.addEventListener(evtType, function () {
                window.calculateAge();
                updateStepperState();
            });
        });
    }

    // Document-level event delegation fallback for dynamic inputs
    ['input', 'change', 'blur', 'keyup'].forEach(evtType => {
        document.addEventListener(evtType, function (e) {
            if (e.target && (e.target.id === 'txtDOB' || e.target.name === 'txtDOB')) {
                window.calculateAge();
                updateStepperState();
            }
        });
    });

    // 100ms Active Polling Watcher to guarantee Age updates regardless of how DOB value changes
    setInterval(function () {
        window.calculateAge();
    }, 100);

    // Initial calculation on page load
    window.calculateAge();

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
                window.previewPhoto(e.target, imgPreviewId);
            });
        }
    }

    // 4. Strict Compulsory Information Form Submission Validation
    const publicForm = document.getElementById('formPublic') || document.querySelector('form');
    if (publicForm) {
        publicForm.addEventListener('submit', function (e) {
            const compulsoryFields = [
                { id: 'txtFullName', name: 'Student Full Name' },
                { id: 'txtDOB', name: 'Date of Birth' },
                { id: 'txtStandard', name: 'Class / Standard' },
                { id: 'txtAddress', name: 'Residential Address' },
                { id: 'txtFatherName', name: 'Father Full Name' },
                { id: 'txtFatherAadhaar', name: 'Father Aadhaar Number' },
                { id: 'txtFatherMobile', name: 'Father Mobile Number' },
                { id: 'txtMotherName', name: 'Mother Full Name' },
                { id: 'txtMotherAadhaar', name: 'Mother Aadhaar Number' },
                { id: 'txtMotherMobile', name: 'Mother Mobile Number' },
                { id: 'txtGuardian1Name', name: 'Guardian 1 Full Name' },
                { id: 'txtGuardian1Rel', name: 'Guardian 1 Relationship' },
                { id: 'txtGuardian1Mobile', name: 'Guardian 1 Mobile Number' }
            ];

            let missing = [];
            compulsoryFields.forEach(field => {
                const el = document.getElementById(field.id);
                if (el) {
                    if (!el.value || !el.value.trim()) {
                        missing.push(field.name);
                        el.style.border = '2px solid #ef4444';
                        el.style.backgroundColor = '#450a0a';
                    } else {
                        el.style.border = '';
                        el.style.backgroundColor = '';
                    }
                }
            });

            if (missing.length > 0) {
                e.preventDefault();
                alert('⚠️ COMPULSORY INFORMATION REQUIRED!\n\nPlease fill in all required compulsory fields marked with * before receipt can be generated:\n- ' + missing.join('\n- '));
                const firstInvalid = document.querySelector('input[style*="ef4444"], textarea[style*="ef4444"]');
                if (firstInvalid) {
                    firstInvalid.focus();
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
                return false;
            }
        });
    }

    // 5. Dynamic URL Query Parameter Renderer for PublicReceipt Page
    if (window.location.pathname.includes('PublicReceipt')) {
        const urlParams = new URLSearchParams(window.location.search);
        
        function getParam(key1, key2, fallback) {
            const val = urlParams.get(key1) || (key2 ? urlParams.get(key2) : null);
            return (val && val.trim()) ? val.trim() : fallback;
        }

        const studentName = getParam('txtFullName', 'sName', null);
        const gender = getParam('ddlGender', 'gender', 'Male');
        const std = getParam('txtStandard', 'std', null);
        const school = getParam('txtSchoolName', 'school', '-');
        const route = getParam('txtComingFrom', 'route', '-');

        const fatherName = getParam('txtFatherName', 'fName', null);
        const fatherAadhaar = getParam('txtFatherAadhaar', 'fAadhaar', '-');
        const fatherMobile = getParam('txtFatherMobile', 'fMobile', null);

        const motherName = getParam('txtMotherName', 'mName', '-');
        const motherAadhaar = getParam('txtMotherAadhaar', 'mAadhaar', '-');
        const motherMobile = getParam('txtMotherMobile', 'mMobile', '-');

        const g1Name = getParam('txtGuardian1Name', 'g1Name', '-');
        const g1Rel = getParam('txtGuardian1Rel', 'g1Rel', '-');
        const g1Mobile = getParam('txtGuardian1Mobile', 'g1Mobile', '-');

        const g2Name = getParam('txtGuardian2Name', 'g2Name', '-');
        const g2Rel = getParam('txtGuardian2Rel', 'g2Rel', '-');
        const g2Mobile = getParam('txtGuardian2Mobile', 'g2Mobile', '-');

        // Check if compulsory info is missing
        const hasCompulsory = studentName && std && fatherName && fatherMobile;

        if (hasCompulsory) {
            // Target elements if present
            const elStudName = document.querySelector('.guardian-card-box .fs-5.text-white');
            if (elStudName) elStudName.textContent = studentName;

            const allValues = document.querySelectorAll('.guardian-card-box span.fw-bold');
            if (allValues.length >= 15) {
                allValues[0].textContent = studentName;
                allValues[1].textContent = gender;
                allValues[2].textContent = std;
                allValues[3].textContent = school;
                allValues[4].textContent = route;

                allValues[5].textContent = fatherName;
                allValues[6].textContent = fatherAadhaar;
                allValues[7].textContent = fatherMobile;

                allValues[8].textContent = motherName;
                allValues[9].textContent = motherAadhaar;
                allValues[10].textContent = motherMobile;

                allValues[11].textContent = g1Name;
                allValues[12].textContent = g1Rel;
                allValues[13].textContent = g1Mobile;

                allValues[14].textContent = g2Name;
                allValues[15].textContent = g2Rel;
                allValues[16].textContent = g2Mobile;
            }

            // Generate 12-Digit Aadhaar Format Numbers (e.g. 4821 9842 1041)
            const r1 = Math.floor(4000 + Math.random() * 5000);
            const r2 = Math.floor(1000 + Math.random() * 8999);
            const rfidFatNo = getParam('rfidFather', null, r1 + ' ' + r2 + ' 1041');
            const rfidMthNo = getParam('rfidMother', null, r1 + ' ' + r2 + ' 1042');
            const rfidG1No  = getParam('rfidG1', null, r1 + ' ' + r2 + ' 1043');
            const rfidG2No  = getParam('rfidG2', null, r1 + ' ' + r2 + ' 1044');

            function setTxt(id, text) {
                const el = document.getElementById(id);
                if (el) el.textContent = text;
            }

            setTxt('lblRfidFatherName', fatherName);
            setTxt('lblRfidFatherNo', rfidFatNo);

            setTxt('lblRfidMotherName', motherName);
            setTxt('lblRfidMotherNo', rfidMthNo);

            setTxt('lblRfidG1Name', g1Name);
            setTxt('lblRfidG1RelTag', g1Rel);
            setTxt('lblRfidG1No', rfidG1No);

            setTxt('lblRfidG2Name', g2Name);
            setTxt('lblRfidG2RelTag', g2Rel);
            setTxt('lblRfidG2No', rfidG2No);

            for (let i = 1; i <= 4; i++) {
                setTxt('lblRfidStudentName' + i, studentName);
                setTxt('lblRfidStudentReg' + i, admNo);
            }

            function getHumanPortraitPhoto(role, themeBg) {
                let hair = '<path d="M30 42 C30 18 70 18 70 42 C75 32 65 14 50 14 C35 14 25 32 30 42 Z" fill="#1e293b"/>';
                let clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#2563eb"/><path d="M42 65 L50 82 L58 65 Z" fill="#ffffff"/><path d="M48 70 L52 70 L51 90 L49 90 Z" fill="#dc2626"/>';
                if (role === 'Mother') {
                    hair = '<path d="M20 52 C16 28 28 8 50 8 C72 8 84 28 80 52 C84 75 76 85 76 85 C76 85 68 58 68 52 C68 32 32 32 32 52 C32 58 24 85 24 85 C24 85 16 75 20 52 Z" fill="#334155"/>';
                    clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#db2777"/><path d="M38 65 Q50 78 62 65 Z" fill="#f472b6"/>';
                } else if (role === 'Guardian1') {
                    hair = '<path d="M28 40 C28 18 72 18 72 40 C75 30 65 12 50 12 C35 12 25 30 28 40 Z" fill="#1e293b"/>';
                    clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#059669"/><path d="M42 65 L50 80 L58 65 Z" fill="#ffffff"/>';
                } else if (role === 'Guardian2') {
                    hair = '<path d="M24 48 C22 26 32 10 50 10 C68 10 78 26 76 48 C78 62 72 75 72 75 C72 78 66 52 66 48 C66 30 34 30 34 48 C34 52 28 75 28 75 Z" fill="#1e293b"/>';
                    clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#7c3aed"/><path d="M40 65 Q50 75 60 65 Z" fill="#c4b5fd"/>';
                }

                const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100">
                    <rect width="100%" height="100%" fill="${themeBg}"/>
                    ${clothes}
                    <circle cx="50" cy="44" r="20" fill="#fde047"/>
                    ${hair}
                    <circle cx="43" cy="42" r="2.5" fill="#1e293b"/>
                    <circle cx="57" cy="42" r="2.5" fill="#1e293b"/>
                    <path d="M44 53 Q50 58 56 53" stroke="#1e293b" stroke-width="2" fill="none"/>
                </svg>`;
                return 'data:image/svg+xml;utf8,' + encodeURIComponent(svg);
            }

            // Populate Uploaded Parent Photos onto Aadhaar RFID Smart Cards
            function setPhoto(id, storageKey, urlKey, paramKey) {
                const img = document.getElementById(id);
                if (!img) return;

                // 1. If element ALREADY has a valid uploaded photo src from server (e.g. /Uploads/ or data:image/png;base64)
                if (img.src && (img.src.includes('/Uploads/') || img.src.includes('Uploads/') || (img.src.includes('data:image') && !img.src.includes('data:image/svg+xml')))) {
                    return; // KEEP SERVER UPLOADED PHOTO!
                }

                // 2. Check sessionStorage or URL params
                const photoFromStorage = sessionStorage.getItem(storageKey);
                const photoFromUrl = getParam(urlKey, paramKey, null) || getParam('file' + storageKey.replace('rfidPhoto', '') + 'Photo', null, null);
                const candidate = photoFromStorage || photoFromUrl;

                if (candidate && candidate.trim() !== '') {
                    const p = candidate.trim();
                    if (p.indexOf('data:image') === 0 || p.indexOf('/Uploads/') === 0 || p.indexOf('Uploads/') === 0 || p.indexOf('http') === 0) {
                        img.src = p;
                    }
                }
            }

            setPhoto('imgRfidFatherPhoto', 'rfidPhotoFather', 'rfidPhotoFather', 'hidFatherPhotoData');
            setPhoto('imgRfidMotherPhoto', 'rfidPhotoMother', 'rfidPhotoMother', 'hidMotherPhotoData');
            setPhoto('imgRfidG1Photo', 'rfidPhotoG1', 'rfidPhotoG1', 'hidGuardian1PhotoData');
            setPhoto('imgRfidG2Photo', 'rfidPhotoG2', 'rfidPhotoG2', 'hidGuardian2PhotoData');

            // Generate Full Information Scannable QR Codes
            function makeQrText(personName, rel, mobile, rfidNo) {
                return 'TN HAPPY KIDS SCHOOL - AUTHORIZED PICKUP PASS\n' +
                       '---------------------------------------------\n' +
                       'Card Holder: ' + personName + '\n' +
                       'Relationship: ' + rel + '\n' +
                       'Student Name: ' + studentName + '\n' +
                       'Class / Std: ' + std + '\n' +
                       'Mobile: ' + mobile + '\n' +
                       'Student Reg No: ' + admNo + '\n' +
                       'RFID Card No: ' + rfidNo + '\n' +
                       'Status: VERIFIED & AUTHORIZED';
            }

            function setQr(id, dataText) {
                const img = document.getElementById(id);
                if (img) img.src = 'https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=' + encodeURIComponent(dataText);
            }

            setQr('imgQrFather', makeQrText(fatherName, 'Father', fatherMobile, rfidFatNo));
            setQr('imgQrMother', makeQrText(motherName, 'Mother', motherMobile, rfidMthNo));
            setQr('imgQrG1', makeQrText(g1Name, g1Rel, g1Mobile, rfidG1No));
            setQr('imgQrG2', makeQrText(g2Name, g2Rel, g2Mobile, rfidG2No));

            // Auto-download receipt PDF only after compulsory details confirmed
            setTimeout(function () {
                downloadReceiptPDF(true);
            }, 800);
        }
    }

    // Initial calculation on load
    calculateAge();
    updateStepperState();
});

function printReport() {
    window.print();
}

/**
 * Downloads receipt card as formatted PDF document
 */
function downloadReceiptPDF(autoTrigger = false) {
    const element = document.querySelector('.printable-area') || document.querySelector('.card');
    if (!element) return;

    if (typeof html2pdf === 'undefined') {
        console.warn('html2pdf library is loading...');
        return;
    }

    const pdfBtn = document.getElementById('btnDownloadPDF');
    if (pdfBtn && !autoTrigger) {
        pdfBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin me-2"></i> Generating PDF...';
        pdfBtn.disabled = true;
    }

    const isPublic = window.location.pathname.includes('PublicReceipt');
    const filename = (isPublic ? 'Admission_Receipt_' : 'Fee_Receipt_') +
        (new Date().toISOString().slice(0, 10)) + '.pdf';

    const opt = {
        margin:       [0.2, 0.2, 0.2, 0.2],
        filename:     filename,
        image:        { type: 'jpeg', quality: 0.98 },
        html2canvas:  { scale: 2, useCORS: true, logging: false, backgroundColor: isPublic ? '#1c2541' : '#ffffff' },
        jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
    };

    html2pdf().set(opt).from(element).save().then(function () {
        if (pdfBtn) {
            pdfBtn.innerHTML = '<i class="fa-solid fa-file-pdf me-2"></i> Download PDF Receipt';
            pdfBtn.disabled = false;
        }
    }).catch(function (err) {
        console.error('PDF Generation Error:', err);
        if (pdfBtn) {
            pdfBtn.innerHTML = '<i class="fa-solid fa-file-pdf me-2"></i> Download PDF Receipt';
            pdfBtn.disabled = false;
        }
    });
}

/**
 * Exports all 4 Parent & Guardian RFID Smart Cards as a formatted PDF
 */
function downloadAllRFIDCardsPDF() {
    const elements = document.querySelectorAll('.rfid-card');
    if (!elements || elements.length === 0) return;

    if (typeof html2pdf === 'undefined') {
        alert('PDF generator is loading, please wait a moment.');
        return;
    }

    const container = document.createElement('div');
    container.style.padding = '20px';
    container.style.background = '#0b132b';
    container.style.color = '#ffffff';

    const headerHtml = `
        <div style="text-align: center; margin-bottom: 20px; border-bottom: 2px solid #38bdf8; padding-bottom: 10px;">
            <h2 style="color: #ffffff; font-weight: 800; margin: 0;">TN HAPPY KIDS SCHOOL</h2>
            <p style="color: #38bdf8; font-weight: 700; margin: 5px 0 0 0;">Official Parent & Guardian RFID Smart Pickup Cards</p>
        </div>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
    `;
    
    let cardsContent = '';
    elements.forEach(card => {
        cardsContent += card.outerHTML;
    });

    container.innerHTML = headerHtml + cardsContent + '</div>';

    const filename = 'Parent_Guardian_RFID_Smart_Cards_' + (new Date().toISOString().slice(0, 10)) + '.pdf';
    const opt = {
        margin:       [0.2, 0.2, 0.2, 0.2],
        filename:     filename,
        image:        { type: 'jpeg', quality: 0.98 },
        html2canvas:  { scale: 2, useCORS: true, logging: false, backgroundColor: '#0b132b' },
        jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
    };

    html2pdf().set(opt).from(container).save();
}

