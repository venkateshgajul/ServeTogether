// scripts.js

// Sample Data for Charts
const volunteerData = [50, 60, 70, 80, 90, 100,50, 60, 70, 80, 90, 100];
const charityData = [30, 40, 50, 60, 70, 80,50, 60, 70, 80, 90, 100];
const donationData = [200, 150, 300, 250, 400, 350, 200, 150, 300, 250, 400, 350];

const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];

// Volunteer & Charity Chart
const ctx = document.getElementById('volunteerCharityChart').getContext('2d');
const volunteerCharityChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: months,
        datasets: [
            {
                label: 'Volunteers',
                data: volunteerData,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            },
            {
                label: 'Charities',
                data: charityData,
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 1)',
                borderWidth: 1
            }
        ]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

// Donation Chart
const donationCtx = document.getElementById('donationChart').getContext('2d');
const donationChart = new Chart(donationCtx, {
    type: 'pie',
    data: {
        labels: months,
        datasets: [{
            data: donationData,
            backgroundColor: [
                'rgba(255, 99, 132, 0.8)',                  
                'rgba(54, 162, 235, 0.8)',
                'rgba(255, 206, 86, 0.8)',
                'rgba(75, 192, 192, 0.8)',
                'rgba(153, 102, 255, 0.8)',
				'rgba(255, 159, 64, 0.8)',
				'rgba(201, 203, 207, 0.8)',
				'rgba(255, 99, 71, 0.8)',
				'rgba(60, 179, 113, 0.8)',
				'rgba(255, 69, 0, 0.8)',
				'rgba(106, 90, 205, 0.8)',
				'rgba(144, 238, 144, 0.8)'
            ],
            borderColor: [
                
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true
    }
});

// Set Counts
document.getElementById('donationCount').innerText = donationData.reduce((a, b) => a + b, 0);
document.getElementById('volunteerCount').innerText = volunteerData.reduce((a, b) => a + b, 0);
document.getElementById('charityCount').innerText = charityData.reduce((a, b) => a + b, 0);

// Download PDF Functionality
document.getElementById('downloadPDF').addEventListener('click', () => {
    const pdfContent = document.querySelector('main').innerHTML;
    const opt = {
        margin: 1,
        filename: 'ServeTogether_Dashboard.pdf',
        html2canvas: { scale: 2 },
        jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
    };

    html2pdf().from(pdfContent).set(opt).save();
});
