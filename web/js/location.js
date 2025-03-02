document.addEventListener("DOMContentLoaded", function () {
    loadProvinces();
});

let locationData = {};

async function loadProvinces() {
    try {
        const response = await fetch("js/tree.json");
        locationData = await response.json();

        const provinceSelect = document.getElementById("province");

        for (const [code, province] of Object.entries(locationData)) {
            const option = document.createElement("option");
            option.value = code;
            option.textContent = province.name_with_type;
            provinceSelect.appendChild(option);
        }
    } catch (error) {
        console.error("Lỗi tải dữ liệu:", error);
    }
}

function loadDistricts() {
    const provinceCode = document.getElementById("province").value;
    const districtSelect = document.getElementById("district");
    districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';

    if (provinceCode && locationData[provinceCode].hasOwnProperty("quan-huyen")) {
        const districts = locationData[provinceCode]["quan-huyen"];
        for (const [code, district] of Object.entries(districts)) {
            const option = document.createElement("option");
            option.value = code;
            option.textContent = district.name_with_type;
            districtSelect.appendChild(option);
        }
    }
}

function loadWards() {
    const provinceCode = document.getElementById("province").value;
    const districtCode = document.getElementById("district").value;
    const wardSelect = document.getElementById("ward");
    wardSelect.innerHTML = '<option value="">Chọn xã/phường</option>';

    if (provinceCode && districtCode && locationData[provinceCode]["quan-huyen"][districtCode].hasOwnProperty("xa-phuong")) {
        const wards = locationData[provinceCode]["quan-huyen"][districtCode]["xa-phuong"];
        for (const [code, ward] of Object.entries(wards)) {
            const option = document.createElement("option");
            option.value = code;
            option.textContent = ward.name_with_type;
            wardSelect.appendChild(option);
        }
    }
}
